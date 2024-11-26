
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../helper/expense_helper.dart';
import '../modal/expense_modal.dart';
import '../services/fire_base_service.dart';

class ContactController extends GetxController {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final FirestoreService firestoreService = FirestoreService();

  var contacts = <Contact>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var filterCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    isLoading(true);
    contacts.value = await dbHelper.getContacts();
    isLoading(false);
  }

  Future<void> addOrUpdateContact(Contact contact) async {
    if (contact.id == null) {
      await dbHelper.addContact(contact);
    } else {
      await dbHelper.updateContact(contact);
    }
    fetchContacts();
  }

  Future<void> deleteContact(int id) async {
    await dbHelper.deleteContact(id);
    fetchContacts();
  }

  Future<void> syncWithFirestore() async {
    List<Contact> localContacts = await dbHelper.getContacts();
    await firestoreService.uploadContacts(localContacts);
    List<Contact> downloadedContacts = await firestoreService.downloadContacts();

    await dbHelper.deleteAllContacts();
    for (var contact in downloadedContacts) {
      await dbHelper.addContact(contact);
    }
    fetchContacts();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}