import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';

// ignore: must_be_immutable
class OutputNode extends ReducerNode {
  OutputNode({
    super.key, 
    required super.id, 
    required super.position, 
    super.label = 'Output',
    super.inputCount = 1,
    super.outputCount = 0,
  });
  @override
  OutputNodeState createState() => OutputNodeState();
}
class OutputNodeState extends ReducerNodeState {
  @override
  Widget body() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
    );
  }
}