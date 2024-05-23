part of 'materialesx_bloc.dart';

@immutable
abstract class MaterialesxState {}

class MaterialesxInitialState extends MaterialesxState {}

class MaterialesxLoadingState extends MaterialesxState{}
class MaterialesxLoadedState extends MaterialesxState{
  List<MaterialesxRepModelo> materialesxList;
  MaterialesxLoadedState(this.materialesxList);
}
class ActividadError extends MaterialesxState{
  Error e;
  ActividadError(this.e);
}