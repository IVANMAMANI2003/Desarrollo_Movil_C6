


import 'package:asistencia_app/apis/materialesx_api.dart';
import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/modelo/MaterialesxModelo.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class MaterialesxRepository{
  MaterialesxApi? servicioApi;

  MaterialesxRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    servicioApi = MaterialesxApi(_dio);
  }

  Future<List<MaterialesxRepModelo>> getEntidad() async {
    print("Holas");

    try{
      servicioApi!.getEntidad(TokenUtil.TOKEN);
    }catch(e){
      print(e);
    }

    return await servicioApi!.getEntidad(TokenUtil.TOKEN);
  }

  Future<GenericModelo> deleteEntidad(int id) async {
    return await servicioApi!.deleteEntidad(TokenUtil.TOKEN,id);
  }

  Future<MaterialesxRepModelo> updateActividad(int id, MaterialesxModelo entidad) async {
    return await servicioApi!.updateEntidad(TokenUtil.TOKEN, id, entidad);
  }

  Future<MaterialesxRepModelo> createActividad(MaterialesxModelo entidad) async {
    return await servicioApi!.createEntidad(TokenUtil.TOKEN, entidad);
  }


}