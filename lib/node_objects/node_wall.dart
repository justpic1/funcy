import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/actions.dart';
import 'package:functional_spreadsheet/node_objects/node.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';
import 'package:functional_spreadsheet/node_objects/types/default/input.dart';
import 'package:functional_spreadsheet/pages/nodepage.dart';
import 'package:functional_spreadsheet/popups/painter.dart';

class NodeWall extends StatefulWidget{
  static List<ReducerNode> children = [];
  static List<ReducerNodeState> states = [];
  final Widget child;
  static int signalKey = 0;
  const NodeWall({super.key, required this.child});
  static void addNode(Node node) {
    //NodePage.actions.addAction(MyAction(node, null, null, 'create'));
    children.add(node as ReducerNode);
  }
  static void run(){
    signalKey += 1;
    for (InputNode input in children.whereType<InputNode>()) {
      input.run(signalKey);
    }
  }
  static void removeNode(Node node) {
    //NodePage.actions.addAction(MyAction(node, null, null, 'delete'));
    children.remove(node as ReducerNode);
  }
  static void updateState() {
    if (states.isNotEmpty) {
      states[0].update();
    }
  }

  @override
  State<StatefulWidget> createState() => NodeWallState();
}
  class NodeWallState extends State<NodeWall> {
    static NodeWallState? current;
    @override

    void initState() {
      super.initState();
      current = this;
    }
    @override
    Widget build(BuildContext context) {
    //print(children);
    //print(states);
    return CustomPaint(
      painter: LinePainter(
      ),
      child: Stack(
        children: [
          widget.child,
          ...NodeWall.children.map((e) => e)
        ],
      ),
    );
  }
} 