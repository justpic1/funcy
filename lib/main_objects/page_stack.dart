
import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/pages/homepage.dart';
import 'package:functional_spreadsheet/pages/nodepage.dart';
import 'package:functional_spreadsheet/pages/sheetpage.dart';
import 'package:functional_spreadsheet/theme.dart';

class PageStack extends StatefulWidget {
  final String title;
  final MaterialPageRoute destination;
  const PageStack({
    super.key,
    required this.destination,
    required this.title,
  });

  @override
  StackState createState() => StackState();
}
class StackState extends State<PageStack> {
  static List<PageStack> states = [
    PageStack(title: "Node", destination: MaterialPageRoute(builder: (context) => const NodePage())),
    PageStack(title: "Sheet", destination: MaterialPageRoute(builder: (context) => const SheetPage())),
    PageStack(title: "Home", destination: MaterialPageRoute(builder: (context) => const HomePage())),
  ];
  late String title;
  late MaterialPageRoute destination;
  static Stack pages() {
    return Stack(
      children: [
        ...states
      ]
    );
  }
  
  @override
  void initState() {
    super.initState();
    title = widget.title;
    destination = widget.destination;
  }
  
  @override
  Widget build(BuildContext context) {
    return page();
  }

  GestureDetector page() {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    return GestureDetector(
      onTap: () {
        if (states.first == widget) {
          return;
        }
        else {
          Navigator.pop(context);
          if (title != "Home") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => destination.builder(context)));
            states.remove(widget);
            states.insert(0, widget);
          }
        }
      },
      child: Container(
        width: 70,
        height:30,
        margin: EdgeInsets.only(
          left: states.indexOf(widget) * 70.0,
        ),
        decoration: BoxDecoration(
          color: states.first == widget ? currentTheme.currentStack : currentTheme.nonCurrentStack,
        ),
        
        alignment: Alignment.center,
        child: Text(
          title,
        ),
      ),
    );
    
  }
}