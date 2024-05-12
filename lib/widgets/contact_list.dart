import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'delete_contact_dialog.dart';
import 'edit_contact_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactList extends StatelessWidget {

  final User user;

  ContactList({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('contact').where("createdby", isEqualTo: user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final contacts = snapshot.data!.docs;

        if (contacts.isEmpty) {
          return Center(
            child: Text('No Contacts found'),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                // DataColumn(label: Text('Last Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Mobile')),
                DataColumn(label: Text('Actions')),
              ],
              rows: contacts.map((contact) {
                var uuid = contact.id;
                final data = contact.data() as Map<String, dynamic>;
                print('UUID is ${uuid} name is ${data['name']}');
                return DataRow(cells: [
                  DataCell(Text(data['name'])),
                  // DataCell(Text(data['lastName'])),
                  DataCell(Text(data['email'])),
                  DataCell(Text(data['mobile'])),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditContactDialog(
                                  contactId: contact.id,
                                  firstName: data['name'],
                                  // lastName: data['lastName'],
                                  email: data['email'],
                                  mobile: data['mobile'],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteContactDialog(
                                  contactId: contact.id,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
