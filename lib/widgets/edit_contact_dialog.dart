import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditContactDialog extends StatefulWidget {
  final String contactId;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;

  EditContactDialog({
    required this.contactId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
  });

  @override
  _EditContactDialogState createState() => _EditContactDialogState();
}

class _EditContactDialogState extends State<EditContactDialog> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    mobileController = TextEditingController(text: widget.mobile);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: mobileController,
            decoration: InputDecoration(labelText: 'Mobile'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('contacts')
                .doc(widget.contactId)
                .update({
              'firstName': firstNameController.text,
              'lastName': lastNameController.text,
              'email': emailController.text,
              'mobile': mobileController.text,
            });
            Navigator.of(context).pop();
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
