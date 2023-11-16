import 'package:flutter/material.dart';
import 'package:tempo_app/model/model_pomodoro.dart';
import 'package:tempo_app/pages/dialog_helper.dart';

class PomodoroTimer {
  Pomodoro? pomodoro = Pomodoro.actualPomodoro;

  BuildContext context;
  List<int> sessions = [];
  static int currentSessionIndex = 0;
  int currentSessionTime = 0;
  int contador = 0;

  PomodoroTimer(this.context) {
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
      if (contador % 2 == 0) {
        DialogHelper.showSessionFinishedDialog(context);
        contador++;
        currentSessionIndex++;
        currentSessionTime = sessions[currentSessionIndex] * 60;
      } else {
        DialogHelper.showBreakFinishedDialog(context);
        contador++;
        currentSessionIndex++;
        currentSessionTime = sessions[currentSessionIndex] * 60;
      }
    } else {
      DialogHelper.showPomodoroFinishedDialog(context);
    }
  }
}