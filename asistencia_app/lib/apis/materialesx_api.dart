

import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/modelo/MaterialesxModelo.dart';
import 'package:asistencia_app/util/UrlApi.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
part 'materialesx_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class MaterialesxApi {
  factory MaterialesxApi(Dio dio, {String baseUrl}) = _MaterialesxApi;
  static MaterialesxApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return MaterialesxApi(dio);
  }

  @GET("/asis/materialesx/list")
  Future<List<MaterialesxRepModelo>> getEntidad(@Header("Authorization") String token);

  @POST("/asis/materialesx/crear")
  Future<MaterialesxRepModelo> createEntidad(@Header("Authorization") String
  token,@Body() MaterialesxModelo entidad);

  @DELETE("/asis/materialesx/eliminar/{id}")
  Future<GenericModelo> deleteEntidad(@Header("Authorization") String token,
      @Path("id") int id);

  @GET("/asis/materialesx/buscar/{id}")
  Future<List<MaterialesxRepModelo>> findEntidad(@Header("Authorization") String token, @Path("id") int id);


  @PATCH("/asis/materialesx/editar/{id}")
  Future<MaterialesxRepModelo> updateEntidad(@Header("Authorization") String
  token,@Path("id") int id, @Body() MaterialesxModelo entidad);

}