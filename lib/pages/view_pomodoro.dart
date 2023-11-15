import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tempo_app/model/model_pomodoro.dart';
import 'package:tempo_app/pages/view_home.dart';

class PomodoroView extends StatefulWidget {
  const PomodoroView({Key? key}) : super(key: key);

  @override
  State<PomodoroView> createState() => _PomodoroViewState();
}

class _PomodoroViewState extends State<PomodoroView> {

  late PomodoroTimer pomodoroTimer;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _validatePomodoro();
  }

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
                                fontWeight: FontWeight.bold
                                ),
                            textAlign: TextAlign.center,
                        )
                      ),
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
                        style: const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(height: 20),
                      Container(
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
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                pomodoroTimer.nextSession();
                              });
                            },
                            child: const Text('Siguiente Sesión',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _validatePomodoro() {
    if (Pomodoro.actualPomodoro == null) {
      Navigator.pop(context);
    } else {
      pomodoroTimer = PomodoroTimer();
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          pomodoroTimer.tick();
        });
      });
    }
  }

}

class PomodoroTimer {
  Pomodoro? pomodoro = Pomodoro.actualPomodoro;

  List<int> sessions = [];
  int currentSessionIndex = 0;
  int currentSessionTime = 0;

  PomodoroTimer() {
    pomodoro?.calculatePomodoroSessions();
    sessions = pomodoro!.sessions;
    currentSessionTime = sessions[currentSessionIndex] * 60;
  }

  void tick() {
    if (currentSessionTime > 0) {
      currentSessionTime--;
    } else {
      nextSession();
    }
  }

  String get formattedCurrentSessionTime {
    int minutes = currentSessionTime ~/ 60;
    int seconds = currentSessionTime % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void nextSession() {
    if (currentSessionIndex < sessions.length - 1) {
      currentSessionIndex++;
      currentSessionTime = sessions[currentSessionIndex] * 60;
    } else {
      // Se ha completado un ciclo, puedes reiniciar o manejar según tus necesidades
      currentSessionIndex = 0;
      currentSessionTime = sessions[currentSessionIndex] * 60;
    }
  }
}
