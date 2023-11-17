import 'package:flutter/material.dart';
import 'package:tempo_app/model/model_pomodoro.dart';
import 'package:tempo_app/model/model_pomodoro_timer.dart';
import 'package:tempo_app/pages/view_tasks.dart';

class DialogHelper {
  static void showPopUpRegisterError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upss... 😒'),
          content: const Text(
              "Ha ocurrido un error al intentar registrarte, por favor intentalo de nuevo mas tarde."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  static void showPomodoroFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Felicidades! 🎉'),
          content: const Text(
              "Has completado tu pomodoro y tu tarea. Si quieres seguir usando pomodoro, selecciona otra tarea."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Tasks()));
                Pomodoro.actualPomodoro = null;
                PomodoroTimer.currentSessionIndex = 0;
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  static void showSessionFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Descansa! 😎'),
          content: const Text(
              "Has completado tu sesión. Ahora toma un descanso de 5min y luego continua con tu siguiente sesión."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  static void showBreakFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡A trabajar! 💪'),
          content: const Text(
              "Tu descanso ha terminado. Ahora continua con tu siguiente sesión."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  static void showPopUpSelectPomodoro(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upss... 😒'),
          content: const Text(
              "Tienes que seleccionar una tarea para poder iniciar el pomodoro."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Tasks()));
              },
              child: const Text('Entiendo'),
            ),
          ],
        );
      },
    );
  }

  static void showPopUpLoginError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upss... 😒'),
          content: const Text(
              'Ha ocurrido un error al intentar ingresar, por favor intentalo de nuevo mas tarde.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  static void showPopUpRegisterDataError(BuildContext context, String errores) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upss... 😒'),
          content:
              Text("Ha ocurrido un error al intentar registrarte. \n$errores"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  static void showPopUpLoginDataError(BuildContext context, String errores) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upss... 😒'),
          content:
              Text('Ha ocurrido un error al intentar ingresar. \n$errores'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  static void showPopUpExistingUserError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upss... 😒'),
          content: const Text(
              'Al parecer ya existe un usuario con el correo ingresado, valida tus datos e intentalo de nuevo..'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  // Define tus otras funciones de diálogo de la misma manera
}
