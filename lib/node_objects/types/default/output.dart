import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/data.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';

// ignore: must_be_immutable
class OutputNode extends ReducerNode {
  OutputNode({
    super.key, 
    required super.position, 
    super.label = 'Output',
    super.inputCount = 1,
    super.outputCount = 0,
    }) {
      DataState.addNode(this);
  }
  @override
  void run(int key){
    List<ReducerNode> inputNodes = inputConnectors.expand((input) => input.connectedOutputs.map((output) => output.connectedNode)).toList();
    if (inputNodes.isEmpty) {
      return;
    }

    signal = inputNodes.expand((node) => node.signal).toList();
    if (signal.isNotEmpty && signal[0] is List) {
      signal = signal[0];
    }
    rs.update();
  }
  @override
  OutputNodeState createState() => OutputNodeState();
}
class OutputNodeState extends ReducerNodeState {
  late OutputNode widget2;
  @override
  void initState(){
    super.initState();
    widget2 = widget as OutputNode;
  }
  @override
  Widget body() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
      child: Text(widget2.signal.toString(),
      ),
    );
  }
}