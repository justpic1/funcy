import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';
// ignore: must_be_immutable
class InputNode extends ReducerNode {
  
  InputNode({
    super.key, 
    required super.id, 
    required super.position, 
    super.label = 'Input',
    super.inputCount = 0, 
    super.outputCount = 1,
  });
  @override
  InputNodeState createState() => InputNodeState();
}
class InputNodeState extends ReducerNodeState {
  @override
  Widget body() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
    );
  }
}