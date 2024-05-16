abstract class Personaje{
  String? poder;
  String nombre;

  Personaje (this.nombre);

  String toString(){
    return "$nombre - $poder";
  }


}

class Heroex extends Personaje{
  int valentia= 100;
  Heroex(String nombre):super(nombre);


}
