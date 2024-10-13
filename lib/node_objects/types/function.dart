import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/connector.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';

// ignore: must_be_immutable
class FunctionNode extends ReducerNode {
  Function function;
  List<Type> types;
  FunctionNode({
    super.key, 
    required super.position, 
    required super.inputCount, 
    required super.outputCount,
    required super.label,
    required this.function,
    required this.types,
  });
  @override
  void run(int key){
    List<ReducerNode> inputNodes = inputConnectors.expand((input) => input.connectedOutputs.map((output) => output.connectedNode)).toList();
    print(types);
    print(inputNodes.map((node) => node.signal.runtimeType));
    print(inputNodes.every((node) => types.contains(node.signal.runtimeType)));
    if (inputNodes.every((node) => types.contains(node.signal.runtimeType))) { 
        if (inputNodes.map((node) => node.signalKey).toSet().length == 1) {
        signal = [(function(inputNodes.map((node) => node.signal).toList()))];
        for (OutputConnector output in outputConnectors) {
          for (InputConnector input in output.connectedInputs) {
            input.connectedNode.run(key);
          }
        }
      }
    }
    else {
      signal = ['x'];
      for (OutputConnector output in outputConnectors) {
        for (InputConnector input in output.connectedInputs) {
          input.connectedNode.run(key);
        }
      }
    }
    rs.update();
  }
  @override
  FunctionNodeState createState() => FunctionNodeState();
}
class FunctionNodeState extends ReducerNodeState {
  late FunctionNode widget2;
  @override
  void initState(){
    super.initState();
    widget2 = widget as FunctionNode;
  }
  @override
  Widget body() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
    );
  }

}