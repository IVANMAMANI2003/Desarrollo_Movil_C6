part of 'actividad_bloc.dart';

@immutable
abstract class ActividadEvent {}
class ListarActividadEvent extends ActividadEvent{
  ListarActividadEvent(){print("Evento si");}
//ListarActividadEvent({required ActividadModelo actividad}):super(actividad:actividad);
}
class DeleteActividadEvent extends ActividadEvent{
  ActividadModeloFire actividad;
  DeleteActividadEvent(this.actividad);
//DeleteActividadEvent({required ActividadModelo actividad}):super(actividad:actividad);
}
class UpdateActividadEvent extends ActividadEvent{
  ActividadModeloFire actividad;
  UpdateActividadEvent(this.actividad);
//UpdateActividadEvent({required ActividadModelo actividad}):super(actividad:actividad);
}
class CreateActividadEvent extends ActividadEvent{
  ActividadModeloFire actividad;
  CreateActividadEvent(this.actividad);
//CreateActividadEvent({required ActividadModelo actividad}):super(actividad:actividad);
}
