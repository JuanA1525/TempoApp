import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tempo_app/model/model_pomodoro.dart';
import 'package:tempo_app/pages/dialog_helper.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validatePomodoro();
    });
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tiempo Restante: ${pomodoroTimer.formattedCurrentSessionTime}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      pomodoroTimer.nextSession();
                    });
                  },
                  child: Text('Siguiente Sesión'),
                ),
              ],
            ),
          ),
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
      DialogHelper.showPopUpSelectPomodoro(context);
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
    pomodoro!.calculatePomodoroSessions();
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
