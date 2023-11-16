import 'package:flutter/material.dart';
import 'package:tempo_app/pages/view_home.dart';

class SleepTable extends StatelessWidget {
  const SleepTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 73, 173),
        body: Stack(children: [
          Image.asset(
            'assets/sleep_proto.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
          Home.navbar(context)
        ]));
  }
}
