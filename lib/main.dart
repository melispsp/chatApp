import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core import
import 'LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBVOfSr4iSj2wUjDZxTFXXfjfoVa5v5ZUQ",
            authDomain: "chatapp-ffb5d.firebaseapp.com",
            projectId: "chatapp-ffb5d",
            storageBucket: "chatapp-ffb5d.firebasestorage.app",
            messagingSenderId: "231131373272",
            appId: "1:231131373272:web:e23a272cb355e477b9c1ad"));
  } else {
    await Firebase.initializeApp();
  }

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
        scaffoldBackgroundColor: const Color.fromARGB(255, 21, 28, 55),
        hintColor: Colors.red,
      ),
      home: const LoginPage(),
    );
  }
}
