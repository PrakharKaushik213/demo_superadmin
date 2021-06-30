import 'package:demo_superadmin/Admin_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Admin',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Admin_Screen(),
    );
  }
}
