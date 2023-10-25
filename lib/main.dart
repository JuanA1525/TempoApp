import 'package:flutter/material.dart';
import 'package:tempo_app/pages/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.blue,
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const Login()
    );
  }
}