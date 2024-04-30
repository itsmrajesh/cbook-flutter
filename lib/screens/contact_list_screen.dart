import 'package:flutter/material.dart';
import '../widgets/contact_list.dart';
import '../widgets/add_contact_dialog.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddContactDialog();
                },
              );
            },
          ),
        ],
      ),
      body: ContactList(),
    );
  }
}
