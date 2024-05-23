part of 'materialesx_bloc.dart';

@immutable
abstract class MaterialesxEvent {}


class ListarMaterialesxEvent extends MaterialesxEvent{
  ListarActividadEvent(){print("Evento si");}
}

class ListarMaterialesxFiltroEvent extends MaterialesxEvent{
  String dato;
  ListarMaterialesxFiltroEvent(this.dato);
}

class DeleteMaterialesxEvent extends MaterialesxEvent{
  int materialesx;
  DeleteMaterialesxEvent(this.materialesx);
}

class UpdateMaterialesxEvent extends MaterialesxEvent{
  MaterialesxModelo materialesx;
  UpdateMaterialesxEvent(this.materialesx);
}
class CreateMaterialesxEvent extends MaterialesxEvent{
  MaterialesxModelo materialesx;
  CreateMaterialesxEvent(this.materialesx);
}