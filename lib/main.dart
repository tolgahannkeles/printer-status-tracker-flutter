import 'package:flutter/material.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/is_working_page.dart';
import 'package:test_app/pages/status_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.amber),
      home: const HomePage(),
    );
  }
}
