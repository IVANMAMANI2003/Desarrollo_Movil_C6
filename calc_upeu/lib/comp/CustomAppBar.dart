import 'package:flutter/material.dart';
import 'package:calc_upeu/theme/AppTheme.dart';
class CustomAppBar extends StatefulWidget implements
    PreferredSizeWidget {
  CustomAppBar({ super.key,
    required this.accionx
  }) : preferredSize = Size.fromHeight(50.0);
  Function accionx;
  @override
  final Size preferredSize;
  @override
  _CustomAppBarState createState() => _CustomAppBarState(accionx);
}
class _CustomAppBarState extends State<CustomAppBar>{
  _CustomAppBarState( this.accionx );
  Function accionx;
  @override
  Widget build(BuildContext context) {
    int coloS=0;
    return AppBar(
      title: Center(child: AppTheme.useMaterial3 ? const Text("Material 3") : const Text("Material 2")),
      actions: [
        IconButton(
          icon: AppTheme.useLightMode? const Icon(Icons.wb_sunny_outlined): const Icon(Icons.wb_sunny),
          onPressed: (){
            setState(() {
              AppTheme.useLightMode = !AppTheme.useLightMode;
              if(AppTheme.useLightMode==true){
                AppTheme.themeDataLight=ThemeData(useMaterial3: AppTheme.useMaterial3,
                    colorScheme: AppTheme.colorOptionsShemeL[AppTheme.colorSelected]
                );
              }else{
                AppTheme.themeDataDark=ThemeData(useMaterial3: AppTheme.useMaterial3,
                    colorScheme: AppTheme.colorOptionsShemeD[AppTheme.colorSelected]
                );
              }

              accionx();
            });
          },
          tooltip: "Toggle brightness",
        ),
        IconButton(
          icon: AppTheme.useMaterial3? const Icon(Icons.filter_3): const Icon(Icons.filter_2),
          onPressed: (){
            setState(() {
              AppTheme.useMaterial3 = !AppTheme.useMaterial3;
              if(AppTheme.useLightMode==true){
                AppTheme.themeDataLight=ThemeData(useMaterial3: AppTheme.useMaterial3,
                    colorScheme: AppTheme.colorOptionsShemeL[AppTheme.colorSelected]
                );
              }else{
                AppTheme.themeDataDark=ThemeData(useMaterial3: AppTheme.useMaterial3,
                    colorScheme: AppTheme.colorOptionsShemeD[AppTheme.colorSelected]
                );
              }
            });
            accionx();
          },
          tooltip: "Switch to Material ${AppTheme.useMaterial3 ? 2 : 3}",
        ),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          itemBuilder: (context) {
            return List.generate(AppTheme.colorOptionsLD.length, (index) {
              return PopupMenuItem(
                value: index,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        index == AppTheme.colorOptionsLD? Icons.color_lens: Icons.color_lens_outlined,
                        color: AppTheme.colorOptionsLD[index],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(AppTheme.colorTextLD[index]))
                  ],
                ),
                onTap: (){
                  coloS=index;
                  AppTheme.colorSelected=coloS;
                },
              );
            });
          },
          onSelected: (valor){
            setState(() {
              if(AppTheme.useLightMode==true){
                AppTheme.themeDataLight=ThemeData(useMaterial3: AppTheme.useMaterial3,
                    colorScheme: AppTheme.colorOptionsShemeL[AppTheme.colorSelected]
                );
              }else{
                AppTheme.themeDataDark=ThemeData(useMaterial3: AppTheme.useMaterial3,
                    colorScheme: AppTheme.colorOptionsShemeD[AppTheme.colorSelected]
                );
              }

            });
            accionx();
          },
        ),
      ],
    );
  }
}
