import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/node.dart';

class NodeWall extends StatefulWidget{
  static List<Node> children = [];
  static List<NodeState> states = [];
  final Widget child;
  const NodeWall({super.key, required this.child});
  static void addNode(Node node) {
    children.add(node);
  }

  static void removeNode(Node node) {
    children.remove(node);
  }
  Widget build(BuildContext context) {
    print(children);
    print(states);
    return Stack(
      
      children: [
        child,
        ...children.map((e) => e)
      ]

    );
  }
  @override
  State<StatefulWidget> createState() => NodeWallState();
}
  
  class NodeWallState extends State<NodeWall> {
    @override
    Widget build(BuildContext context) {
      return widget.build(context);
  }
  
}