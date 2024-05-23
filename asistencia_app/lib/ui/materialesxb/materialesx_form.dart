
import 'package:asistencia_app/bloc/actividad/actividad_bloc.dart';
import 'package:asistencia_app/bloc/materialesx/materialesx_bloc.dart';
import 'package:asistencia_app/comp/DropDownFormField.dart';
import 'package:asistencia_app/modelo/ActividadModelo.dart';
import 'package:asistencia_app/modelo/MaterialesxModelo.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaterialesxForm extends StatefulWidget {
  @override
  _MaterialesxFormState createState() => _MaterialesxFormState();
}

class _MaterialesxFormState extends State<MaterialesxForm> {

  Position? currentPosition;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  late String _cui ="";
  late String _tipoCui="DNI";
  late String _materiales="";
  late String _actividadID="0";
  late String _offlienex="NO";

  List<Map<String, String>> lista = [
    {'value': 'DNI', 'display': 'DNI'},
    {'value': 'CARNET', 'display': 'CARNET'}
  ];
  List<Map<String, String>> listaOffline = [
    {'value': 'SI', 'display': 'SI'},
    {'value': 'NO', 'display': 'NO'}
  ];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ActividadBloc>(context).add(ListarActividadEvent());
  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  void capturaCui(valor){ this._cui=valor;}
  void capturaTipoCui(valor){ this._tipoCui=valor;}
  void capturaMateriales(valor){ this._materiales=valor;}
  void capturaActividadID(valor){ this._actividadID=valor;}
  void capturaModoOffline(valor){ this._offlienex=valor;}

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Materiales B"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              //color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    _buildDatoLista(capturaTipoCui,_tipoCui, "T.Cui:", lista),
                    _buildDatoCadena(capturaCui, "CUI:"),
                    _buildDatoCadena(capturaMateriales,"Entrega Mat:"),

                    BlocBuilder<ActividadBloc, ActividadState>(
                        builder: (context, state) {
                          List<Map<String, String>> listaAct = [];
                          listaAct.clear();
                          listaAct.add({'value': "0", 'display': "Seleccione..."});
                          if(state is ActividadLoadedState){
                            state.ActividadList.forEach((element) {
                              listaAct.add({'value': element.id.toString(), 'display': element.nombreActividad});
                            });
                            return _buildDatoLista(capturaActividadID,_actividadID, "Actividad:", listaAct);
                          }else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                    ),
                    _buildDatoLista(capturaModoOffline,_offlienex, "Offlie:", listaOffline),


                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState!.save();
                                MaterialesxModelo mp = new MaterialesxModelo.unlaunched();
                                mp.cui = _cui;
                                mp.id=0;
                                mp.tipoCui=_tipoCui;
                                mp.materEntre=_materiales;
                                mp.latituda=currentPosition!.latitude.toString();
                                mp.longituda=currentPosition!.longitude.toString();
                                mp.actividadId=int.parse(_actividadID);
                                mp.offlinex=_offlienex;
                                final nowx = DateTime.now();
                                mp.fecha=DateFormat('yyyy-MM-dd').format(nowx);
                                mp.horaReg=DateFormat('HH:mm:ss').format(nowx);
                                mp.modFh=DateFormat('yyyy-MM-dd').format(nowx);
                                //print(int.parse(_actividadID));
                                //print(DateFormat('yyyy-MM-dd').format(nowx));
                                //print(DateFormat('HH:mm:ss').format(nowx));
                                //print(DateFormat('yyyy-MM-dd HH:mm:ss').format(nowx));
                                //print(mp.toJson());

                                BlocProvider.of<MaterialesxBloc>(context).add(CreateMaterialesxEvent(mp));
                                Navigator.pop(context, () {
                                  //setState(() {});
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget _buildDatoLista(Function obtValor,_dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }

  Future<bool> permiso() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void>  getCurrentLocation() async {
    final hasPermission = await permiso();
    if (!hasPermission) {
      return;
    }
    if (mounted){
      Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true)
          .then((Position position) {
        if(mounted){
          setState(() {
            currentPosition = position;
            //getCurrentLocationAddress();
          });
        }
      }).catchError((e) {
        print(e);
      });
    }
  }

}