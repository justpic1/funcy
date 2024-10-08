import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/main_objects/page_stack.dart';
import 'package:functional_spreadsheet/popups/menu.dart';
import 'package:functional_spreadsheet/popups/rc_node.dart';
import 'package:functional_spreadsheet/theme.dart';

class NodePage extends StatelessWidget {
  const NodePage({super.key});

  @override
  Widget build(BuildContext context) {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    return Scaffold(
      backgroundColor: currentTheme.nodeBg,
      appBar: appBar(),
      body: Stack(
        children: [   
          const RcNode(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  toolBar1(currentTheme),
                  const Spacer(flex: 1),
                  toolBar2(currentTheme),
                ],
              ),
            ],
            
          ),
        ],
      ),
    );
  }

  SizedBox toolBar2(MyTheme currentTheme) {
    return SizedBox(
      height: 100.0,
      width: 200,
      child: Container(
        alignment: AlignmentDirectional.topEnd,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: currentTheme.slate,
        ),
      ),
    );
  }

  SizedBox toolBar1(MyTheme currentTheme) {
    return SizedBox(
      height: 100.0,
      width: 600,
      child: Container(
        alignment: AlignmentDirectional.topStart,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: currentTheme.slate,
        ),
        child: StackState.pages()
      ),
    );
  }

  AppBar appBar() {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    return AppBar(
      leading: const Menu(),
      centerTitle: true,
      title: Text(
        'Func(y)',
        style: TextStyle(
            color: currentTheme.textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: currentTheme.colorAppBar,
      toolbarHeight: 20,
    );
  }
}
