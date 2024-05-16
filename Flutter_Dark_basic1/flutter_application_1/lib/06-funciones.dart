void maine() {
final nombre = 'Fernando';
saludar(nombre);
saludar(nombre, "Probando");
saludar2(nombre: nombre, mensaje: "Saludos");
saludar2(mensaje: "Ver para creer", nombre: nombre);

}
void saludar(String nombre, [String mensaje = 'Hi']) 
{
print('$mensaje $nombre');
}
void saludar2({
required String nombre,
required String mensaje,
}) {
print('$mensaje $nombre');
}
