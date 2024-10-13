import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:functional_spreadsheet/node_objects/types/default/default.dart';
import 'package:functional_spreadsheet/node_objects/types/default/input.dart';
import 'package:functional_spreadsheet/node_objects/types/default/output.dart';
import 'package:functional_spreadsheet/popups/painter.dart';
import 'package:functional_spreadsheet/theme.dart';
import 'package:signals/signals.dart';
class RcNode extends StatefulWidget {
  final bool on;
  final Widget? child;

  const RcNode({
    super.key,
    this.on = true,
    this.child,
  });

  @override
  SelectState createState() => SelectState();
}

class SelectState extends State<RcNode> {
  late bool on;
  static List<SelectState> states = [];
  static double x = 0.0;
  static double y = 0.0;

  @override
  void initState() {
    super.initState();
    on = widget.on;
    states.add(this);
    if (NodeWall.children.isEmpty) {
      createTestNodes();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    TextStyle style = TextStyle(
      color: currentTheme.textColor,
      fontSize: 10,
    );
    
    return gDNode(context, currentTheme, style);
  }

  NodeWall gDNode(BuildContext context, MyTheme currentTheme, TextStyle style) {
    return NodeWall(child: mouseRegion(context, currentTheme, style)
    );
  }

  MouseRegion mouseRegion(BuildContext context, MyTheme currentTheme, TextStyle style) {
    return MouseRegion(
    onHover:(PointerHoverEvent event) {
      _updateLocation(event);
      // update NodeWall State
      NodeWall.updateState();
    },
    onEnter: _updateLocation,
        child: GestureDetector(
          onTap: () {
            LinePainter.deleteLine(x, y);
          },
          onDoubleTap: () {
            NodeWall.run();
          },
          onPanUpdate: (details) => {
            for (var state in NodeWall.states) {
              state.move(
                Offset(
                  state.widget.position.value.dx - details.delta.dx/3,
                  state.widget.position.value.dy - details.delta.dy/3,
                )
              )
            }
          },
          onSecondaryTap: () {
            final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                x,
                y,
                overlay.size.width - x,
                overlay.size.height - y,
              ), 
              color: currentTheme.mainBg,
              constraints: const BoxConstraints(maxWidth: 80),
              items: [
                PopupMenuItem<int>(value: 0, height: 20, child: Text('Add Node', style: style)),
                PopupMenuItem<int>(value: 1, height: 20, enabled: false, child: Text('Delete Node', style: style)),
                PopupMenuItem<int>(value: 2, height: 20, child: Text('Item 3', style: style)),
              ],
              ).then((value) {
              if (value != null) {
                onSelected(value);
              }
              });
          },
      ),
    );
  }

  void onSelected(int item) {
    switch (item) {
      case 0:
        nodeSelect();
        break;
      case 1:
        // Handle Item 2 action
        break;
      case 2:
        // Handle Item 3 action
        break;
        }
      }

  Future<dynamic> nodeSelect() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
      var style = TextStyle(
        color: MyTheme.getCurrentTheme().textColor,
        fontSize: 10,
      );
      return AlertDialog(
        backgroundColor: MyTheme.getCurrentTheme().mainBg,
        title: Text('Select an Option', style: style),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Input Node', style: style),
            onTap: () {
          Navigator.of(context).pop();
          // Handle Option 1 action
          NodeWall.addNode(InputNode(position: Signal(Offset(x, y)), outputCount: 1));

          
            },
          ),
          ListTile(
            title: Text('Output Node', style: style),
            onTap: () {
          Navigator.of(context).pop();
          // Handle Option 2 action
          NodeWall.addNode(OutputNode(position: Signal(Offset(x, y)), inputCount: 1,));
            },
          ),
          ListTile(
            title: Text('Function Node', style: style),
            onTap: () {
          Navigator.of(context).pop();
          // Handle Option 3 action
          NodeWall.addNode(DefaultNodes.sum(Offset(x, y), 5));
            },
          ),
        ],
          ),
        ),
      );
        },
      );
      
  }
  void _updateLocation(PointerEvent details) {
    setState(() {
    x = details.position.dx;
    y = details.position.dy;
      });
    }
    void createTestNodes() {
      var inputNode = InputNode(position: Signal(const Offset(50, 50)), outputCount: 1);
      var outputNode = OutputNode(position: Signal(const Offset(150, 150)), inputCount: 1);
      NodeWall.addNode(inputNode);
      NodeWall.addNode(outputNode);

      // Connect the output of the input node to the input of the output node
    }
    void getNodesFromData() {

    }
}