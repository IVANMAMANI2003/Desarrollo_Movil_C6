
import 'package:asistencia_app/modelo/ActividadModelo.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MaterialesxModelo {
  MaterialesxModelo({
    required this.id,
    required this.cui,
    required this.tipoCui,
    required this.materEntre,
    required this.fecha,
    required this.horaReg,
    required this.latituda,
    required this.longituda,
    required this.modFh,
    required this.offlinex,
    required this.actividadId,
  });
  late final int id;
  late final String cui;
  late final String tipoCui;
  late final String materEntre;
  late final String fecha;
  late final String horaReg;
  late final String latituda;
  late final String longituda;
  late final String modFh;
  late final String offlinex;
  late final int actividadId;
  MaterialesxModelo.unlaunched();

  MaterialesxModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    cui = json['cui'];
    tipoCui = json['tipoCui'];
    materEntre = json['materEntre'];
    fecha = json['fecha'];
    horaReg = json['horaReg'];
    latituda = json['latituda'];
    longituda = json['longituda'];
    modFh = json['modFh'];
    offlinex = json['offlinex'];
    actividadId = json['actividadId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cui'] = cui;
    _data['tipoCui'] = tipoCui;
    _data['materEntre'] = materEntre;
    _data['fecha'] = fecha;
    _data['horaReg'] = horaReg;
    _data['latituda'] = latituda;
    _data['longituda'] = longituda;
    _data['modFh'] = modFh;
    _data['offlinex'] = offlinex;
    _data['actividadId'] = actividadId;
    return _data;
  }
}

class MaterialesxRepModelo {
  MaterialesxRepModelo({
    required this.id,
    required this.cui,
    required this.tipoCui,
    required this.materEntre,
    required this.fecha,
    required this.horaReg,
    required this.latituda,
    required this.longituda,
    required this.modFh,
    required this.offlinex,
    required this.actividadId,
  });
  late final int id;
  late final String cui;
  late final String tipoCui;
  late final String materEntre;
  late final String fecha;
  late final String horaReg;
  late final String latituda;
  late final String longituda;
  late final String modFh;
  late final String offlinex;
  late final ActividadModelo actividadId;



  MaterialesxRepModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    cui = json['cui'];
    tipoCui = json['tipoCui'];
    materEntre = json['materEntre'];
    fecha = json['fecha'];
    horaReg = json['horaReg'];
    latituda = json['latituda'];
    longituda = json['longituda'];
    modFh = json['modFh'];
    offlinex = json['offlinex'];
    actividadId = ActividadModelo.fromJson(json['actividadId']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cui'] = cui;
    _data['tipoCui'] = tipoCui;
    _data['materEntre'] = materEntre;
    _data['fecha'] = fecha;
    _data['horaReg'] = horaReg;
    _data['latituda'] = latituda;
    _data['longituda'] = longituda;
    _data['modFh'] = modFh;
    _data['offlinex'] = offlinex;
    _data['actividadId'] = actividadId.toJson();
    return _data;
  }
}