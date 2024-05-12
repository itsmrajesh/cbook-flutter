import 'package:flutter/material.dart';
import '../widgets/contact_list.dart';
import '../widgets/add_contact_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactListScreen extends StatelessWidget {

  final User user;

  ContactListScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var msg = 'Contacts: ${user.email!}';
    return Scaffold(
      appBar: AppBar(
        title: Text(msg),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddContactDialog(
                    user: user,
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Sign out the user
              await FirebaseAuth.instance.signOut();
              // Navigate back to the sign-in screen or any other screen
              // Example: Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ContactList(user: user,),
    );
  }
}
