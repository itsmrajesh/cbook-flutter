import 'package:flutter/material.dart';

import 'auth_date.dart';

class MyAppNew extends StatelessWidget {
  const MyAppNew({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}