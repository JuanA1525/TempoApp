import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempo_app/Service/database_services.dart';
import 'package:tempo_app/enum/priority.dart';
import 'package:tempo_app/enum/state.dart';
import 'package:tempo_app/model/model_custom_user.dart';
import 'package:tempo_app/model/model_pomodoro.dart';
import 'package:tempo_app/pages/view_home.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final _formTaskKey = GlobalKey<FormState>();

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TextEditingController _taskDurationController = TextEditingController();

  ePriority cPriority = ePriority.mid;
  eState cState = eState.toDo;

  final List<String> _optionsPriority = [
    'Ignorar',
    'Baja',
    'Media',
    'Alta',
    'Muy alta'
  ];
  String? _selectedOptionPriority;

  final List<String> _optionsState = ['Por hacer', 'Realizado'];
  String? _selectedOptionState;

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
                    child: const Center(
                      child: Text(
                        'Mis tareas:',
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(25),
                  padding: const EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //-----------------BUTTON Create Task-----------------
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Crear tarea',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  content: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 0, 116, 225),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 450,
                                    width: 900,
                                    alignment: Alignment.center,
                                    transformAlignment: Alignment.center,
                                    child: Form(
                                      key: _formTaskKey,
                                      child: Column(
                                        children: [
                                          //-----------------INPUT Name-----------------
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 30, right: 30),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3))
                                              ],
                                            ),
                                            child: TextFormField(
                                              controller: _taskNameController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText: 'Nombre',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Por favor ingresa un nombre!';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          //-----------------INPUT Description-----------------
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 30, right: 30),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3))
                                              ],
                                            ),
                                            child: TextFormField(
                                              controller:
                                                  _taskDescriptionController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText:
                                                    'Descripcion (Opcional)',
                                              ),
                                            ),
                                          ),

                                          //-----------------INPUT Priority-----------------

                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 30, right: 30),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3))
                                              ],
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: _selectedOptionPriority,
                                              items: _optionsPriority
                                                  .map((String option) {
                                                return DropdownMenuItem<String>(
                                                  value: option,
                                                  child: Text(option),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedOptionPriority =
                                                      newValue;
                                                  switch (
                                                      _selectedOptionPriority) {
                                                    case "Ignorar":
                                                      cPriority =
                                                          ePriority.ignore;
                                                      break;
                                                    case "Baja":
                                                      cPriority = ePriority.low;
                                                      break;
                                                    case "Media":
                                                      cPriority = ePriority.mid;
                                                      break;
                                                    case "Alta":
                                                      cPriority =
                                                          ePriority.high;
                                                      break;
                                                    case "Muy alta":
                                                      cPriority = ePriority.top;
                                                      break;
                                                    default:
                                                      cPriority = ePriority.mid;
                                                      break;
                                                  }
                                                });
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor:
                                                    const Color(0xFFFFFFFF),
                                                hintText:
                                                    'Seleccione la prioridad',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                            ),
                                          ),

                                          //-----------------INPUT State-----------------

                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 30, right: 30),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3))
                                              ],
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: _selectedOptionState,
                                              items: _optionsState
                                                  .map((String option) {
                                                return DropdownMenuItem<String>(
                                                  value: option,
                                                  child: Text(option),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedOptionState =
                                                      newValue;
                                                  switch (
                                                      _selectedOptionState) {
                                                    case "Por hacer":
                                                      cState = eState.toDo;
                                                      break;
                                                    case "Realizado":
                                                      cState = eState.done;
                                                      break;
                                                    default:
                                                      cPriority = ePriority.mid;
                                                      break;
                                                  }
                                                });
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor:
                                                    const Color(0xFFFFFFFF),
                                                hintText:
                                                    'Seleccione el estado',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                            ),
                                          ),

                                          //-----------------INPUT Duration-----------------
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 30, right: 30),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3),
                                                )
                                              ],
                                            ),
                                            child: TextFormField(
                                              controller:
                                                  _taskDurationController,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    4),
                                              ],
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText: 'Duración en minutos',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Por favor ingresa la duración en minutos!';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          //-----------------BUTTON Create Task-----------------

                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            child: TextButton(
                                              onPressed: () {
                                                if (_formTaskKey.currentState!
                                                    .validate()) {
                                                  int duration = int.parse(
                                                      _taskDurationController
                                                          .text);
                                                  setState(() {
                                                    DatabaseServices.addTask(
                                                        name:
                                                            _taskNameController
                                                                .text,
                                                        description:
                                                            _taskDescriptionController
                                                                .text,
                                                        priority: cPriority,
                                                        state: cState,
                                                        duration:
                                                            duration); // Obtiene el valor del controlador
                                                    _taskNameController.clear();
                                                    _taskDescriptionController
                                                        .clear();
                                                    _taskDurationController
                                                        .clear();
                                                  });
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 20,
                                                            left: 30,
                                                            right: 30)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                shape:
                                                    MaterialStateProperty.all(
                                                        const CircleBorder()),
                                                shadowColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.black
                                                            .withOpacity(0.5)),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        10),
                                              ),
                                              child: const Icon(
                                                Icons.send,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 116, 225),
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 30, right: 30)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            shadowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black.withOpacity(0.5)),
                            elevation: MaterialStateProperty.all(20),
                          ),
                          child: const Text(
                            'Crear tarea',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 11, 83, 208)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 25),
                  child: const Text(
                    "Lista de tareas:",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),

                // ----------------- TASKS LIST -----------------

                Container(
                  width: 400,
                  margin: const EdgeInsets.only(top: 20, bottom: 75),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: CustomUser.usuarioActual!.taskList.length,
                    itemBuilder: (context, index) {
                      if (CustomUser.usuarioActual!.taskList.isEmpty) {
                        return const Text("Aun no hay tareas");
                      } else {
                        return Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            margin: const EdgeInsets.only(
                                right: 30, left: 30, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      CustomUser.usuarioActual!.taskList[index].name.length <= 17
                                      ? CustomUser.usuarioActual!.taskList[index].name
                                      : "${CustomUser.usuarioActual!.taskList[index].name.substring(0, 14)}...",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 2, 78, 209)),
                                    ),
                                    Text(
                                      CustomUser.usuarioActual!.taskList[index].description!.length <= 20
                                      ? CustomUser.usuarioActual!.taskList[index].description!
                                      : "${CustomUser.usuarioActual!.taskList[index].description!.substring(0, 20)}...",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 25, 25, 25)),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Prioridad: ${CustomUser.usuarioActual!.getPriority(index)}",
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                    Text(
                                      "Estado: ${CustomUser.usuarioActual!.getState(index)}",
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.timer_sharp,
                                      color: Colors.blueAccent),
                                  onPressed: () {
                                    setState(() {
                                      Pomodoro.createPomodoro(
                                          CustomUser
                                              .usuarioActual!.taskList[index],
                                          context);
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.blueAccent),
                                  onPressed: () {
                                    setState(() {
                                      DatabaseServices.deleteTask(
                                          task: CustomUser
                                              .usuarioActual!.taskList[index]);
                                    });
                                  },
                                ),
                              ],
                            ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Home.navbar(context),
        ],
      ),
    );
  }
}
