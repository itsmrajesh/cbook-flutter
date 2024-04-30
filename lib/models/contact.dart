import 'package:cloud_firestore/cloud_firestore.dart';


class Contact {
  String name;
  String mobile;

  Contact({required this.name, required this.mobile});

  Contact.fromJson(Map<String, Object?> json):
      this(name: json['name']! as String, mobile: json['mobile'] as String);
}