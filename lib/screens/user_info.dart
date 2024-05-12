import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyUserInfo extends StatelessWidget {
  final User user;

  MyUserInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the HomeScreen!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'User Email: ${user.email}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'User UID: ${user.uid}',
              style: TextStyle(fontSize: 18),
            ),
            // You can access other user properties like displayName, photoURL, etc.
          ],
        ),
      ),
    );
  }
}
