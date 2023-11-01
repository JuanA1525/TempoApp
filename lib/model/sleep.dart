import 'package:tempo_app/enum/quality.dart';

class Sleep{

  final String sDate;
  final eQuality quality; //enum de la calidad
  final double duration; //en minutos
  
  Sleep({
    required this.sDate,
    required this.quality,
    required this.duration
  });
}

