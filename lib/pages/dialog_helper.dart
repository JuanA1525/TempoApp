import 'package:flutter/material.dart';
import 'package:tempo_app/pages/view_tasks.dart';

class DialogHelper {

    static void showPopUpRegisterError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upss... 😒'),
          content: const Text("Ha ocurrido un error al intentar registrarte, por favor intentalo de nuevo mas tarde."),
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

  static void showPopUpSelectPomodoro(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upss... 😒'),
          content: const Text("Tienes que seleccionar una tarea para poder iniciar el pomodoro."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Tasks()));
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
          content: const Text('Ha ocurrido un error al intentar ingresar, por favor intentalo de nuevo mas tarde.'),
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
          content: Text("Ha ocurrido un error al intentar registrarte. \n$errores"),
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
          content: Text('Ha ocurrido un error al intentar ingresar. \n$errores'),
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
          content: const Text('Al parecer ya existe un usuario con el correo ingresado, valida tus datos e intentalo de nuevo..'),
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
