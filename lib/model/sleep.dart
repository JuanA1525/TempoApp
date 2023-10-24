import 'package:tempo_app/enum/quality.dart';

class Sleep{
  final DateTime fecha;
  final Quality calidad; //enum de la calidad
  final int duracion; //en minutos

  Sleep({
    required this.fecha,
    required this.calidad,
    required this.duracion
  });
}

