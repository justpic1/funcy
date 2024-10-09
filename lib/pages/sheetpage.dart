import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/main_objects/page_stack.dart';
import 'package:functional_spreadsheet/popups/menu.dart';
import 'package:functional_spreadsheet/sheet_objects/sheet.dart';
import 'package:functional_spreadsheet/theme.dart';
class SheetPage extends StatelessWidget {
  const SheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyTheme currentTheme = MyTheme.currentMyTheme;
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            alignment: AlignmentDirectional.topStart,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
              color: currentTheme.slate,
             ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 120,
            width: MediaQuery.of(context).size.width,
            child: const Sheet(),
          )
        ],
      )
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SheetPage(),
  ));
}
 AppBar appBar() {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    return AppBar(
      leading: const Row(children: [
        Menu(),
      ],),
      centerTitle: true,
      title: Text(
        'Func(y)',
        
        style: TextStyle(
          color: currentTheme.textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: currentTheme.colorAppBar,
      toolbarHeight: 20,
      
    );
  }