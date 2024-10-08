
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:functional_spreadsheet/main_objects/main_pages.dart';
import 'package:functional_spreadsheet/main_objects/select.dart';
import 'package:functional_spreadsheet/pages/nodepage.dart';
import 'package:functional_spreadsheet/theme.dart';

class MainPagesState extends State<MainPages> {
  //im so sorry
  static MainPagesState object = MainPagesState();
  @override
  void initState() {
    super.initState();
    object = this;
  }
  @override
  Widget build(BuildContext context) {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    if (MainPages.load == "Home"){
      return Container(
        constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
        child: SvgPicture.asset("icons/logo.svg"),
      );
    }
    else if (MainPages.load == "New"){
      return Expanded(
        child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                container(currentTheme, 'Blank Editor', constraints),
                container(currentTheme, 'Blank Spreadsheet', constraints),
                container(currentTheme, 'Import Preset', constraints),
              ],
            );
          }
        ),
      );
    }
    else {//if (MainPages.load == "Open"){
      return Container(
        constraints: const BoxConstraints(maxHeight: 300, maxWidth: 800),
        color: Colors.amber,
      ); 
    }// Ensure a Widget is always returned
    
  }

  GestureDetector container(MyTheme currentTheme, String text, BoxConstraints constraints) {
    double maxValue = min(constraints.maxHeight + 100, constraints.maxWidth)/3; 
    return GestureDetector(
      onTap:(){
        MainPages.load = "Home";
        object.setState(() {});
        SelectState().setAllOff();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NodePage())
        );
      },
      child: Container(
        
        constraints: BoxConstraints(maxWidth: maxValue, maxHeight: maxValue),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentTheme.slate,
          border: Border.all(color: currentTheme.outlineColor, width: 2)
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: currentTheme.textColor, fontSize: 20)
        ),
      )
    );
  }
  update(){
  object.setState(() {});
  }
}
Container bubble(){
  return Container(

  );
}