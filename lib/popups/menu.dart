import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/theme.dart';

class Menu extends StatefulWidget {
  final bool on;
  const Menu({
    super.key,
    this.on = true,
  });

  @override
  SelectState createState() => SelectState();
}

class SelectState extends State<Menu> {
  late bool on;
  static List<SelectState> states = [];
  @override
  void initState() {
    super.initState();
    on = widget.on;
    states.add(this);
  }

  @override
  Widget build(BuildContext context) {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    TextStyle style = TextStyle(
      color: currentTheme.textColor,
      fontSize: 10
    );
    return Container(
      padding: const EdgeInsets.all(0),
      color: Colors.pink,
      child: GestureDetector(
        onTap: () {
          final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
          showMenu(

            context: context,
            position: RelativeRect.fromRect(
              Rect.fromPoints(
                overlay.localToGlobal(Offset.zero),
                overlay.localToGlobal(overlay.size.bottomRight(Offset.zero)),
              ),
              Offset.zero & overlay.size,
            ),
            color: currentTheme.mainBg,
            popUpAnimationStyle: AnimationStyle(duration: const Duration(milliseconds: 200)),
            constraints: const BoxConstraints(maxWidth: 80),
            items: [
              PopupMenuItem<int>(value: 0, height: 20, child: Text('Item 1', style: style),),
              PopupMenuItem<int>(value: 1, height: 20, child: Text('Item 2', style: style),),
              PopupMenuItem<int>(value: 2, height: 20, child: Text('Item 3', style: style),),
            ]
          );
        },
        child: Container(
          color: Colors.amber,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: const Text('-',
            style:TextStyle(
              fontSize: 20,
            )
          )
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // Handle Item 1 action
        break;
      case 1:
        // Handle Item 2 action
        break;
      case 2:
        // Handle Item 3 action
        break;
    }
  }
}
