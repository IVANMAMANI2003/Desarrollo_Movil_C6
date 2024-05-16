import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejclaseabstracta.dart';
import 'package:flutter_application_1/ejemploHerencia.dart';



void mainp() {
 var objH = Heroe(nombre: 'Ivan Mamani');
  print(objH.toString());

  var dd = new Gato();
  dd.comer();

    var ob= Heroex( "Ivan");
     print(ob.toString());
}

//Ejemplo de Clase
class Heroe {
  String nombre;
  String? poder;

  Heroe({required this.nombre});

  String toString() {
    return 'Heroe: nombre: ${this.nombre}';
  }


}