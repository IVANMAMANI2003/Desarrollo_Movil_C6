
void main() {
  
  double a = 5;
  double b = 3;
  

  OperacionConcreta operacion = OperacionConcreta();

  print("Ivan Yomar Mamani Merma");
  print("Operaciones Basicas");
  print("");

  print('Suma: ${operacion.suma(a, b)}'); 
  print('Resta: ${operacion.resta(a, b)}');
  print('Multiplicación: ${operacion.multiplicacion(a, b)}');
}

// Definición de la clase abstracta Operacion
abstract class Operacion {
  // Métodos abstractos para suma, resta y multiplicación
  double suma( a,  b);
  double resta( a,  b);
  double multiplicacion( a,  b);
}

// Implementación de la clase derivada
class OperacionConcreta implements Operacion {

  double suma( a,  b) {
    return a + b;
  }

 
  double resta( a,  b) {
    return a - b;
  }


  double multiplicacion( a,  b) {
    return a * b;
  }
}

