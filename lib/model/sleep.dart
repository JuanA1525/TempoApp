import 'package:tempo_app/enum/quality.dart';

class Sleep{
  final DateTime date;
  final Quality quality; //enum de la calidad
  final int duration; //en minutos

  Sleep({
    required this.date,
    required this.quality,
    required this.duration
  });
}

