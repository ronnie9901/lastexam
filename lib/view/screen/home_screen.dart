import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/expense_controller.dart';
import '../../modal/expense_modal.dart';


class ContactHomePage extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () => contactController.syncWithFirestore(),
          ),
          IconButton(
            icon: Icon(Icons.backup),
            onPressed: () => contactController.syncWithFirestore(),
          ),

        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() {
              if (contactController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return _buildContactList();
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOrEditContactDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          contactController.setSearchQuery(value);
        },
      ),
    );
  }

  Widget _buildContactList() {
    final filteredContacts = contactController.contacts.where((contact) {
      final matchesCategory = contactController.filterCategory.value == 'All' ||
          contact.category == contactController.filterCategory.value;
      final matchesQuery = contact.name
          .toLowerCase()
          .contains(contactController.searchQuery.value.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    return ListView.builder(
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];

        return Card(
          color: contact.isFavorite ? Colors.yellow[100] : null,
          child: ListTile(
            leading: Icon(
              contact.isFavorite ? Icons.star : Icons.star_border,
              color: contact.isFavorite ? Colors.yellow[700] : Colors.grey,
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phoneNumber),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: contact.isFavorite,
                  onChanged: (bool? value) {
                    contact.isFavorite = value!;
                    contactController.addOrUpdateContact(contact);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showAddOrEditContactDialog(context, contact);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    contactController.deleteContact(contact.id!);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddOrEditContactDialog(BuildContext context, [Contact? contact]) {
    final TextEditingController nameController =
    TextEditingController(text: contact?.name);
    final TextEditingController phoneController =
    TextEditingController(text: contact?.phoneNumber);
    final TextEditingController emailController =
    TextEditingController(text: contact?.email);
    final TextEditingController categoryController =
    TextEditingController(text: contact?.category);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(contact == null ? 'Add Contact' : 'Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newContact = Contact(
                  id: contact?.id,
                  name: nameController.text,
                  phoneNumber: phoneController.text,
                  email: emailController.text,
                  category: categoryController.text,
                  isFavorite: contact?.isFavorite ?? false,
                );
                contactController.addOrUpdateContact(newContact);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}