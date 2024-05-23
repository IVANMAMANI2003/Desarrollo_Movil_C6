import 'package:asistencia_app/apis/actividad_api.dart';
import 'package:asistencia_app/local/condb/conexiondb.dart';
import 'package:asistencia_app/modelo/ActividadModelo.dart';
import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/util/NetworConnection.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:dio/dio.dart';
class ActividadRepository with ConexionDBL{
  ActividadApi? actividadApi;

  ActividadRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    actividadApi = ActividadApi(_dio);
  }



  Future<List<ActividadModelo>> getActividad() async {
    final actividaddDao= (await conetion()).actividadDao;
    if(await isConected()){
      //return await actividadApi!.getActividad(TokenUtil.TOKEN).then((value) => value.data);
      var dato=await actividadApi!.getActividad(TokenUtil.TOKEN).then((value) => value);
      dato.forEach((el) async{
        await actividaddDao.insertActividad(new ActividadModelo(id: el.id,
          nombreActividad: el.nombreActividad, fecha: el.fecha, horai: el.horai, minToler: el.minToler,
          latitud: el.latitud, longitud: el.longitud, estado: el.estado, evaluar: el.evaluar, userCreate: el.userCreate,
          mater: el.mater,validInsc: el.validInsc,asisSubact: el.asisSubact,entsal: el.entsal,offlinex: el.offlinex,
        ));
      });
      //final result = await actividaddDao.findActividadById(18);
      //return await dato;
      return await actividaddDao.findAllActidad();
    }else{
      return await actividaddDao.findAllActidad();
    }
  }

  Future<GenericModelo> deleteActividad(int id) async {
    final actividaddDao= (await conetion()).actividadDao;
    if(await isConected()){
      actividaddDao.deleteActividad(id);
      return await actividadApi!.deleteActividad(TokenUtil.TOKEN,id);
    }else{
      actividaddDao.deleteActividad(id);
      Map<String, dynamic> resultado = {'deleted':true};
      return Future.value(GenericModelo.fromJson(resultado));
    }
  }

  Future<ActividadModelo> updateActividad(int id, ActividadModelo actividad) async {
    final actividaddDao= (await conetion()).actividadDao;
    if(await isConected()){
      return await actividadApi!.updateActividad(TokenUtil.TOKEN, id, actividad);
    }else{
      actividaddDao.updateActividad(actividad);
      return actividad;
    }
  }

  Future<ActividadModelo> createActividad(ActividadModelo actividad) async {
    final actividaddDao= (await conetion()).actividadDao;
    if(await isConected()){
      return await actividadApi!.crearActividad(TokenUtil.TOKEN, actividad);
    }else{
      actividaddDao.insertActividad(actividad);
      return await actividad;
    }
  }


}