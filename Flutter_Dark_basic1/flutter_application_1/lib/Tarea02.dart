
void main() {
  
  double x = 5;
  double y = 3;
  

  OperacionConcreta operacion = OperacionConcreta();

  print("Christian Salas Yupanqui");
  print("");

  print('La suma es: ${operacion.suma(x, y)}'); 
  print('La resta es: ${operacion.resta(x, y)}');
  print('La multiplicación es: ${operacion.multiplicacion(x, y)}');
}

// Definición de la clase abstracta Operacion
abstract class Operacion {
  // Métodos abstractos para suma, resta y multiplicación
  double suma( x,  y);
  double resta( x,  y);
  double multiplicacion( x,  y);
}

// Implementación de la clase derivada
class OperacionConcreta extends Operacion {

  double suma( x,  y) {
    return x + y;
  }

 
  double resta( x,  y) {
    return x - y;
  }


  double multiplicacion( x,  y) {
    return x * y;
  }
}

