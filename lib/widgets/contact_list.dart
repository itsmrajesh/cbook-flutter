import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'delete_contact_dialog.dart';
import 'edit_contact_dialog.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('contacts').snapshots(),
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
        print('ID is ${contacts[0].id}');

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: DataTable(
              columns: [
                DataColumn(label: Text('First Name')),
                DataColumn(label: Text('Last Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Mobile')),
                DataColumn(label: Text('Actions')),
              ],
              rows: contacts.map((contact) {
                var uuid = contact.id;
                final data = contact.data() as Map<String, dynamic>;
                print('UUID is ${uuid} name is ${data['firstName']}');
                return DataRow(cells: [
                  DataCell(Text(data['firstName'])),
                  DataCell(Text(data['lastName'])),
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
                                  firstName: data['firstName'],
                                  lastName: data['lastName'],
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
