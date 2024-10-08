import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:functional_spreadsheet/main_objects/main_pages.dart';
import 'package:functional_spreadsheet/main_objects/main_pages_state.dart';
import 'package:functional_spreadsheet/theme.dart';

class Select extends StatefulWidget {
  
  final String title;
  final String iconPath;
  final ColorFilter? colorFilter;
  final bool selected;

  const Select({
    super.key,
    required this.title,
    required this.iconPath,
    this.selected = false,
    this.colorFilter,

  });

  @override
  SelectState createState() => SelectState();
}

class SelectState extends State<Select> {
  late bool selected;
  static List<SelectState> states = [];
  @override
  void initState() {
    super.initState();
    selected = widget.selected;
    states.add(this);
  }

  @override
  Widget build(BuildContext context) {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    return SizedBox(
      width: 125,
      height: 125,
      child: GestureDetector(
        onTap: () {
          setAllOff();
          setState(() {
            selected = true;
            MainPages.load = widget.title;
            MainPagesState().update();

          });
        },
        child: Stack(
          alignment: const Alignment(0,2.5),
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: selected ? currentTheme.outlineColor : currentTheme.unselected,
                  width: 2,
                ),
              ),
              child: SvgPicture.asset(
                widget.iconPath,
                colorFilter: widget.colorFilter,
              ),
            ),
            Text(widget.title,
            style: TextStyle(fontSize: 30, color: currentTheme.textColor),
            )
          ],
        ),
      ),
    );
  }
  void setOff() {
    setState(() {
      selected = false;
    });
  }
  void setAllOff(){
    for (SelectState i in states){
      i.setOff();
    }
  }
}

