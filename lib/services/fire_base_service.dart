import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modal/expense_modal.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> uploadContacts(List<Contact> contacts) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      for (var contact in contacts) {
        await _db
            .collection('users')
            .doc(user.uid)
            .collection('contacts')
            .doc(contact.id.toString())
            .set(contact.toMap());
      }
    }
  }

  Future<List<Contact>> downloadContacts() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await _db
          .collection('users')
          .doc(user.uid)
          .collection('contacts')
          .get();
      return querySnapshot.docs
          .map((doc) => Contact.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}