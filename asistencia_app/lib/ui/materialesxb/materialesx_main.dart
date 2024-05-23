import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:asistencia_app/bloc/actividad/actividad_bloc.dart';
import 'package:asistencia_app/bloc/materialesx/materialesx_bloc.dart';
import 'package:asistencia_app/comp/TabItem.dart';
import 'package:asistencia_app/modelo/MaterialesxModelo.dart';
import 'package:asistencia_app/repository/ActividadRepository.dart';
import 'package:asistencia_app/repository/MaterialesxRepository.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/ui/help_screen.dart';
import 'package:asistencia_app/ui/materialesxb/materialesx_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MainMaterialesxB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>MaterialesxBloc( MaterialesxRepository())),
        BlocProvider(create: (_)=>ActividadBloc( ActividadRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeDataLight,
        darkTheme: AppTheme.themeDataDark,
        home: MaterialesxUI(),
      ),
    );
  }
}

class MaterialesxUI extends StatefulWidget {
  @override
  _MaterialesxUIState createState() => _MaterialesxUIState();
}

class _MaterialesxUIState extends State<MaterialesxUI> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var api;
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MaterialesxBloc>(context).add(ListarMaterialesxEvent());
  }

  _loanData()async{
    final bloc = BlocProvider.of<ActividadBloc>(context);


  }

  final GlobalKey<AnimatedFloatingActionButtonState> key =
  GlobalKey<AnimatedFloatingActionButtonState>();

  String text = 'Materiales';
  String subject = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  Future onGoBack(dynamic value) async {
    setState(() {
      print(value);
    });
  }
  void accion(){
    setState(() {
    });
  }

  void accion2(){
    setState(() {
      print("Holaas");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeDataLight,
      darkTheme: AppTheme.themeDataDark,
      home: Scaffold(

        appBar: new AppBar(
          title: Text(
            'Lista de Materiales Bloc',
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona");
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona 2");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MaterialesxForm()),
                  ).then(onGoBack);
                },
                child: Icon(Icons.add_box_sharp),
              ),
            )
          ],
        ),


        backgroundColor: AppTheme.nearlyWhite,
        body: BlocBuilder<MaterialesxBloc,MaterialesxState>(
          builder: (context,state){
            if(state is MaterialesxLoadedState){
              return _buildListView(context, state.materialesxList);
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),

        bottomNavigationBar: _buildBottomTab(),
        floatingActionButton: AnimatedFloatingActionButton(
          key: key,
          fabButtons: <Widget>[
            add(),
            image(),
            inbox(),
          ],
          colorStartAnimation: AppTheme.themeData.colorScheme.inversePrimary,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close,
        ),

      ),
    );
  }

  Widget _buildListView(BuildContext context, List<MaterialesxRepModelo> entidad) {
    return CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 8.0),
                  child: TextFormField(
                    onChanged: (value){
                      //updateList(value);
                      BlocProvider.of<MaterialesxBloc>(context).add(ListarMaterialesxFiltroEvent(value));
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Buscar Actividad...",
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear_sharp,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _controller.clear();
                            BlocProvider.of<MaterialesxBloc>(context).add(ListarMaterialesxFiltroEvent(_controller.value.text));
                            //updateList(_controller.value.text);
                          }),
                      //fillColor: const Color.fromARGB(95, 119, 68, 50),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                )
                ,
                Container(
                  height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/5,
                  //padding: const EdgeInsets.only(bottom: 40.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: ListView.builder(
                      itemCount: entidad.length,
                      itemBuilder: (context, index) {
                        MaterialesxRepModelo entidadx = entidad[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Card(

                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(

                                      title: Row(
                                        children: [
                                          Container(
                                            child: Text(entidadx.tipoCui+" "+entidadx.cui,
                                                style: Theme.of(context).textTheme.bodyMedium

                                            ),
                                          )
                                        ],
                                      ),
                                      subtitle: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: AppTheme.themeData.colorScheme.primaryContainer),
                                              child: Text(
                                                entidadx.materEntre,
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 16),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: AppTheme.themeData.colorScheme.primaryContainer),
                                              child: Text(
                                                //personax.asistenciaxs.isEmpty? personax.evaluar:personax.asistenciaxs.first.horaReg,
                                                ":SI",
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 16),
                                              ),
                                            ),
                                          ]),
                                      leading: CircleAvatar(
                                        backgroundImage:
                                        AssetImage("assets/imagen/man-icon.png"),
                                      ),
                                      trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Expanded(child: IconButton(
                                                      icon: Icon(Icons.edit),
                                                      iconSize: 24,
                                                      padding: EdgeInsets.zero,
                                                      constraints: BoxConstraints(),
                                                      onPressed: () {
                                                        /*Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ActividadFormEdit(
                                                    modelA: entidadx)),
                                          ).then(onGoBack);*/
                                                      })),
                                                  Expanded(child: IconButton(
                                                      icon: Icon(Icons.delete),
                                                      iconSize: 24,
                                                      padding: EdgeInsets.zero,
                                                      constraints: BoxConstraints(),
                                                      //color: AppTheme.themeData.colorScheme.inversePrimary,
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            barrierDismissible: true,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                title:
                                                                Text("Mensaje de confirmacion"),
                                                                content: Text("Desea Eliminar?"),
                                                                actions: [
                                                                  FloatingActionButton(
                                                                    child: const Text('CANCEL'),
                                                                    onPressed: () {
                                                                      Navigator.of(context)
                                                                          .pop('Failure');
                                                                    },
                                                                  ),
                                                                  FloatingActionButton(
                                                                      child: const Text('ACCEPT'),
                                                                      onPressed: () {
                                                                        Navigator.of(context)
                                                                            .pop('Success');
                                                                      })
                                                                ],
                                                              );
                                                            }).then((value) {
                                                          if (value.toString() == "Success") {
                                                            BlocProvider.of<MaterialesxBloc>(context).add(DeleteMaterialesxEvent(entidadx.id));
                                                          }
                                                        });
                                                      }))
                                                ],
                                              ),
                                            )
                                            ,
                                            Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Expanded(child: IconButton(
                                                    icon: Icon(Icons.qr_code),
                                                    padding: EdgeInsets.zero,
                                                    constraints: BoxConstraints(),
                                                    onPressed: () {
                                                      /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyAppQR(modelA: entidadx,)),
                                        ).then(onGoBack);*/
                                                    },
                                                  ),),

                                                  Expanded(child: Builder(
                                                    builder: (BuildContext context) {
                                                      return IconButton(
                                                        icon: Icon(Icons.send_and_archive_sharp),
                                                        padding: EdgeInsets.zero,
                                                        constraints: BoxConstraints(),
                                                        onPressed: () async{

                                                        },
                                                      );
                                                    },
                                                  ))
                                                ],
                                              ),
                                            )

                                          ])
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },

                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ]
          ))
        ],
    );
  }

  int selectedPosition = 0;
  final tabs = ['Home', 'Profile', 'Help', 'Settings'];

  _buildBottomTab() {
    return BottomAppBar(
      //color: AppTheme.themeData.colorScheme.primaryContainer,

      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            icon: Icons.menu,
            text: tabs[0],
            isSelected: selectedPosition == 0,
            onTap: (){
              setState(() {
                selectedPosition = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return  HelpScreen();
              }));
            },
          ),
          TabItem(
            icon: Icons.person,
            text: tabs[1],
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
              });
            },
          ),

          TabItem(text: tabs[2], icon: Icons.help, isSelected: selectedPosition == 2, onTap: () {
            setState(() {
              selectedPosition = 2;
            });
          },),
          TabItem(text: tabs[3], icon: Icons.settings, isSelected: selectedPosition == 3, onTap: () {
            setState(() {
              selectedPosition = 3;
            });
          },),
        ],
      ),
    );
  }


  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          key.currentState?.closeFABs();
        },
        heroTag: Text("Image"),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: Text("Image"),
        tooltip: 'Image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: Text("Inbox"),
        tooltip: 'Inbox',
        child: Icon(Icons.inbox),
      ),
    );
  }


}