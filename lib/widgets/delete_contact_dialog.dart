import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteContactDialog extends StatelessWidget {
  final String contactId;

  DeleteContactDialog({required this.contactId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Contact'),
      content: Text('Are you sure you want to delete this contact?'),
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
                .doc(contactId)
                .delete();
            Navigator.of(context).pop();
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
