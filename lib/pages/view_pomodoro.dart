// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tempo_app/model/model_pomodoro.dart';
import 'package:tempo_app/model/model_pomodoro_timer.dart';
import 'package:tempo_app/pages/view_home.dart';

class PomodoroView extends StatefulWidget {
  const PomodoroView({super.key,});

  @override
  State<PomodoroView> createState() => _PomodoroViewState();
}

class _PomodoroViewState extends State<PomodoroView> {

  @override
  void initState() {
    super.initState();
    try {
      _validatePomodoro();
    } catch (e) {}
  }

  late PomodoroTimer pomodoroTimer = PomodoroTimer(context);
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF352BFF),
      body: Stack(
        children: [
          Image.asset(
            'assets/register_bg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            color: const Color.fromARGB(112, 0, 49, 90),
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                        child: Text(
                      'Pomodoro \n${Pomodoro.actualPomodoro?.taskName}',
                      maxLines: 3,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/temp_clock.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Tiempo Restante: ${pomodoroTimer.formattedCurrentSessionTime}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pomodoroTimer.nextSession();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3))
                            ],
                          ),
                          height: 50,
                          width: 150,
                          child: const Center(
                            child: Text(
                              'Siguiente Sesión',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Home.navbar(context)
        ],
      ),
    );
  }

  void _validatePomodoro() {
    try {
      if (Pomodoro.actualPomodoro == null) {
        Navigator.pop(context);
      } else {
        timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
          setState(() {
            pomodoroTimer.tick();
          });
        });
      }
    } catch (e) {}
  }
}


