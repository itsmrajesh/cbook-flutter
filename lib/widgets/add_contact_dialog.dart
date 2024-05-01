import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContactDialog extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  // final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  bool _validateInputs() {
    return firstNameController.text.isNotEmpty &&
        // lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        mobileController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          // TextField(
          //   controller: lastNameController,
          //   decoration: InputDecoration(labelText: 'Last Name'),
          // ),
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
            if (_validateInputs()) {
              await FirebaseFirestore.instance.collection('contact').add({
                'name': firstNameController.text,
                // 'lastName': lastNameController.text,
                'email': emailController.text,
                'mobile': mobileController.text,
              });
              // Clear text fields after adding contact
              firstNameController.clear();
              // lastNameController.clear();
              emailController.clear();
              mobileController.clear();
              Navigator.of(context).pop();
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Validation Error'),
                    content: Text('Please fill in all fields.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
