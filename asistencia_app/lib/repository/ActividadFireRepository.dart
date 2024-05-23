import 'dart:async';
import 'dart:convert';
import 'package:asistencia_app/modelo/ActividadModeloFire.dart';
import 'package:asistencia_app/util/NetworConnection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ActividadFireRepository {
/*final actividadx={"evaluar":"SI","fecha":"2023-01-
01","user_create":"Davidmp","estado":"Activo","longitud":"3434","latitud":"333","nombre_actividad":"David",
"min_toler":"00:15","periodo_id":1,"horai":"11:15"};
FirebaseFirestore.instance.collection("actividad").add(actividadx).then((DocumentReference doc) =>
print('DocumentSnapshot added with ID: ${doc.id}'));*/
  CollectionReference db = FirebaseFirestore.instance.collection("actividad");
//Aquí código
  Future<List<ActividadModeloFire>> getActividad() async {
    if (await isConected()) {
      var data = await db.get();
      var actividad = data.docs.map((d) {
        Map<String, dynamic> jsonMap = jsonDecode(json.encode(d.data()));
        ActividadModeloFire eventData =
        ActividadModeloFire.fromJson(jsonMap);
        eventData.id = d.id;
        print("Data ${eventData.id}");
        return eventData;
      }).toList();
      return actividad!;
    } else {
      print('No hay internet');
      return null!;
    }
  }

  Future<void> createActividad(ActividadModeloFire actividad)
  async {
    if (await isConected()) {
      return await db
          .add(actividad.toMap())
          .then((value) => print("El id es : ${value.id}"))
          .catchError((onError) => print("Error $onError"));
    } else {
      print('No hay internet');
    }
  }

  Future<void> deleteActividad(String id) async {
    if (await isConected()) {
      return await db
          .doc(id)
          .delete()
          .then((value) => print("Actividad Deleted "))
          .catchError((error) => print("Failed to delete actividad: $error"));
    } else {
      print('No hay conexion a internet FireBase!!');
    }
  }

  Future<void> updateActividad(String id, ActividadModeloFire actividad) async {
    if (await isConected()) {
      print("Verrr: ${id}");
      return await db
          .doc(id)
          .update(actividad.toMap())
          .then((value) => print("Actividad Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    } else {
      print('No hay conexion a internet FireBase!!');
    }
  }

  Future<ActividadModeloFire> buscarActividad(String id) async {
    if (await isConected()) {
      var data = await db.doc(id).get();
      Map<String, dynamic> jsonMap = jsonDecode(json.encode(data.data()));
      ActividadModeloFire eventData = ActividadModeloFire.fromJson(jsonMap);
      print("Data ${eventData.id}");
      return eventData;
    } else {
      print('No hay conexion a internet FireBase!!');
      return null!;
    }
  }

}