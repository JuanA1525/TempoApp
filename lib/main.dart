import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tempo_app/firebase_options.dart';
import 'package:tempo_app/pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Firebase
  runApp(const MainApp());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //Firebase
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