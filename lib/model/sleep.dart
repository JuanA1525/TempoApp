import 'package:tempo_app/enum/quality.dart';
import 'package:tempo_app/model/custom_user.dart';

class Sleep{

  String? id;
  final String sDate;
  final eQuality quality; //enum de la calidad
  final double duration; //en minutos
  
  Sleep({
    this.id,
    required this.sDate,
    required this.quality,
    required this.duration
  }){
    id = CustomUser.usuarioActual!.mail + CustomUser.usuarioActual!.sleepCount.toString();
  }
}

