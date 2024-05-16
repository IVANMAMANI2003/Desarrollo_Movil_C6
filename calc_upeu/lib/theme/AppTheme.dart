import 'package:calc_upeu/theme/theme-red.dart';
import 'package:calc_upeu/theme/theme-skyblue.dart';
import 'package:flutter/material.dart';
class AppTheme {
  static Color colorX = Color(0xff99ff05);
  static List<Color> colorOptions = [
    Colors.purple,
    Colors.green,
    Colors.teal,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    colorX
  ];
  AppTheme._();
  static List<String> colorText = <String>[
  "Purple",
  "Green",
  "Teal",
  "Yellow",
  "Orange",
  "Pink",
  "Personalizado",
  ];
  static bool useMaterial3 = false;
  static bool useLightMode = true;
  static int colorSelected = 1;
  static ThemeData themeData = ThemeData(
      colorSchemeSeed: AppTheme.colorOptions[AppTheme.colorSelected],
      useMaterial3: AppTheme.useMaterial3,
      brightness: AppTheme.useLightMode ? Brightness.light : Brightness.dark);

  static TextTheme textTheme = TextTheme(
    headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    // Añade más estilos de texto según necesites
  );

  static List<ColorScheme> colorOptionsShemeL = [
    MaterialThemeSkyblue(textTheme).light().colorScheme,
    //lightColorSchemeBlue,
    MaterialThemeSkyblue(textTheme).lightMediumContrast().colorScheme,
    MaterialThemeSkyblue(textTheme).lightHighContrast().colorScheme,
    MaterialThemeRed(textTheme).light().colorScheme
  ];
  static List<ColorScheme> colorOptionsShemeD = [
    MaterialThemeSkyblue(textTheme).dark().colorScheme,
    //darkColorSchemeBlue,
    MaterialThemeSkyblue(textTheme).darkMediumContrast().colorScheme,
    MaterialThemeSkyblue(textTheme).darkHighContrast().colorScheme,
    MaterialThemeRed(textTheme).dark().colorScheme
  ];

  static List<Color> colorOptionsLD = <Color>[Colors.blue, Colors.lightBlue, Colors.lightBlueAccent, Colors.red];
  static List<String> colorTextLD = <String>["Blue", "BlueL", "BlueLI", "Red"];

  static ThemeData themeDataLight=ThemeData(useMaterial3: useMaterial3,
  colorScheme: AppTheme.colorOptionsShemeL[AppTheme.colorSelected]);
  static ThemeData themeDataDark=ThemeData(useMaterial3: useMaterial3,
  colorScheme: AppTheme.colorOptionsShemeD[AppTheme.colorSelected]);
}//Comentar


