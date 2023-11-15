import 'package:flutter/material.dart';
import 'package:tempo_app/pages/view_pomodoro.dart';

import 'model_task.dart';

class Pomodoro {
  static Pomodoro? actualPomodoro;
  String? taskName;

  int duration;
  int workTime;
  int shortBreakTime;
  int longBreakTime;

  int cantshortBreak;
  int cantLongBreak;
  int cantWorkTime;

  List<int> sessions = [];

  Pomodoro(
      {this.duration = 75,
      this.workTime = 25,
      this.shortBreakTime = 5,
      this.longBreakTime = 15,
      this.cantWorkTime = 0,
      this.cantLongBreak = 0,
      this.cantshortBreak = 0}) {
    if (cantWorkTime != 0) {
      duration = cantWorkTime * workTime;
      cantWorkTime = 0;
    }
    calculatePomodoroSessions();
  }

  void calculatePomodoroSessions() {
    int remainingTime = duration;
    int contShort = 0;

    while (remainingTime > 0) {
      sessions.add(workTime);
      remainingTime -= workTime;
      cantWorkTime++;

      if (contShort < 2) {
        if (remainingTime > 0) {
          sessions.add(shortBreakTime);
          cantshortBreak++;
          contShort++;
        }
      } else {
        if (remainingTime > 0) {
          sessions.add(longBreakTime);
          cantLongBreak++;
          contShort = 0;
        }
      }

      if (remainingTime < workTime && remainingTime > 0) {
        sessions.add(remainingTime);
        cantWorkTime++;
        remainingTime = -remainingTime;
      }
    }
  }

  static void createPomodoro(Task task, BuildContext context) {
    actualPomodoro = Pomodoro(duration: task.duration!);
    actualPomodoro!.taskName = task.name;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PomodoroView()
        )
    );

  }
}
