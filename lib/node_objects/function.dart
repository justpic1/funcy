import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';

// ignore: must_be_immutable
class FunctionNode extends ReducerNode {
  Function function;
  List<List<dynamic>> inputs;
  FunctionNode({
    super.key, 
    required super.id, 
    required super.position, 
    required super.inputCount, 
    required super.outputCount,
    required super.label,
    required this.function,
    required this.inputs,
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