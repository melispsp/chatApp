import 'package:flutter/material.dart';
import 'LoginPage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amasya Üniversitesi',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 27, 35, 48),
        hintColor: Colors.red,
      ),
      home: const LoginPage(),
    );
  }
}
