import 'package:flutter/material.dart';

class MyTheme{
  static MyTheme currentMyTheme = MyTheme(
    colorAppBar: Colors.black,
    outlineColor: Colors.blue,
    slate: const Color.fromARGB(255, 50, 50, 50),
    options: Colors.amber,
    mainBg: Colors.black,
    nodeBg: Colors.blueGrey,
    ssBg: Colors.black,
    colorGrid: Colors.white,
    textColor: Colors.white,
    );
  static bool lightMode = false;
  Color colorAppBar;
  Color outlineColor;
  Color slate;
  Color options;
  Color mainBg;
  Color nodeBg;
  Color ssBg;
  Color colorGrid; 
  Color textColor;
  Color unselected;
  Color currentStack;
  Color nonCurrentStack;
  Color input;
  Color output;
  MyTheme({
    required this.colorAppBar,
    required this.outlineColor,
    required this.slate,
    required this.options,
    required this.mainBg,
    required this.nodeBg,
    required this.ssBg,
    required this.colorGrid,
    this.textColor = Colors.white,
    this.unselected = Colors.white,
    this.currentStack = Colors.white,
    this.nonCurrentStack = Colors.blueGrey,
    this.input = Colors.red,
    this.output = const Color.fromARGB(255, 160, 212, 255),
 
  });
  static List<MyTheme> getThemes(){
    List<MyTheme> themes = [];
    themes.add(
      MyTheme(
        colorAppBar: Colors.black,
        outlineColor: Colors.blue,
        slate: Colors.grey,
        options: Colors.amber,
        mainBg: Colors.black,
        nodeBg: Colors.blueGrey,
        ssBg: Colors.black,
        colorGrid: Colors.white,
      )
    );
    return themes;
  }
  static MyTheme getCurrentTheme(){
    return currentMyTheme;
  }
}
