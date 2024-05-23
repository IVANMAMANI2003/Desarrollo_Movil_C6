import 'dart:async';

import 'package:asistencia_app/modelo/MaterialesxModelo.dart';
import 'package:asistencia_app/repository/MaterialesxRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'materialesx_event.dart';
part 'materialesx_state.dart';

class MaterialesxBloc extends Bloc<MaterialesxEvent, MaterialesxState> {
  late final MaterialesxRepository _materialesxRepository;
  late List<MaterialesxRepModelo> lista;
  late List<MaterialesxRepModelo> listaB;
  MaterialesxBloc(this._materialesxRepository) : super(MaterialesxInitialState()) {
    on<MaterialesxEvent>((event, emit) async{

      print("Bloc x");
      if(event is ListarMaterialesxEvent){
        emit(MaterialesxLoadingState());
        try{
          print("pasox!!");
          List<MaterialesxRepModelo> entidadList= await _materialesxRepository.getEntidad();
          lista=List.from(entidadList);
          listaB=List.from(lista);
          emit(MaterialesxLoadedState(lista));
        } catch(e){
          emit(ActividadError(e as Error)) ;
        }
      }else if(event is ListarMaterialesxFiltroEvent){
        try{
          lista = listaB
              .where(
                (element) => element.materEntre.toLowerCase().contains(
                  event.dato.toLowerCase(),
            ),
          ).toList();
          emit(MaterialesxLoadedState(lista));
        }catch(e){
          emit(ActividadError(e as Error));
        }
      }else if(event is DeleteMaterialesxEvent){
        try{
          await _materialesxRepository.deleteEntidad(event.materialesx!);
          emit(MaterialesxLoadingState());
          List<MaterialesxRepModelo> entidadList= await _materialesxRepository.getEntidad();
          emit(MaterialesxLoadedState(entidadList));
        }catch(e){
          emit(ActividadError(e as Error));
        }
      }else if(event is CreateMaterialesxEvent){
        try{
          await _materialesxRepository.createActividad(event.materialesx!);
          emit(MaterialesxLoadingState());
          List<MaterialesxRepModelo> entidadList= await _materialesxRepository.getEntidad();
          emit(MaterialesxLoadedState(entidadList));
        }catch(e){
          emit(ActividadError(e as Error));
        }
      }else if(event is UpdateMaterialesxEvent){
        try{
          await _materialesxRepository.updateActividad(event.materialesx!.id, event.materialesx!);
          emit(MaterialesxLoadingState());
          List<MaterialesxRepModelo> entidadList= await _materialesxRepository.getEntidad();
          emit(MaterialesxLoadedState(entidadList));
        }catch(e){
          emit(ActividadError(e as Error));
        }
      }

    });
  }

  List<MaterialesxRepModelo> getListActividad(){
    return lista;
  }




}
