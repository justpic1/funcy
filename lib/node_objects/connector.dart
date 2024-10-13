import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';
import 'package:functional_spreadsheet/popups/painter.dart';
import 'package:functional_spreadsheet/theme.dart';
// ignore: must_be_immutable
abstract class Connector extends StatefulWidget {
  late Color color;
  ReducerNode connectedNode;
  Connector({required this.connectedNode, super.key});
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return key.toString();
  }
}

// ignore: must_be_immutable
class InputConnector extends Connector {
  List<OutputConnector> connectedOutputs = [];
  InputConnector(ReducerNode connectedNode, {super.key}) : super(connectedNode: connectedNode) {
    color = MyTheme.currentMyTheme.input;
  }
  
  @override
  InputConnectorState createState() => InputConnectorState();
}

class InputConnectorState extends State<InputConnector> {
    @override
    Widget build(BuildContext context) {
        return Container(
          height: 20,
          width: 10,
          color: widget.color,
          child: gD(),
      
    );      
  }
  GestureDetector gD() {
    return GestureDetector(
      onTap:() => {
        LinePainter.p.addInput(this),
      },
    );
  }
}
// ignore: must_be_immutable
class OutputConnector extends Connector {
  List<InputConnector> connectedInputs = [];
  
  OutputConnector(ReducerNode connectedNode, {super.key}) : super(connectedNode: connectedNode) {
    color = MyTheme.currentMyTheme.output;
  }
  void disconnect(InputConnector input){
    connectedInputs.remove(input);
    input.connectedOutputs.remove(this);
  }
  @override
  OutputConnectorState createState() => OutputConnectorState();
}
class OutputConnectorState extends State<OutputConnector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 10,
      color: widget.color,
      child: gD(),
    );
  }
  void addConnection(InputConnector input){
    LinePainter.addLines([
      [input,
      widget]
    ]);
  }
  void connect(InputConnector input){
    widget.connectedInputs.add(input);
    addConnection(input);
    input.connectedOutputs.add(widget);
  }
  
  GestureDetector gD() {
    return GestureDetector(
      onTap:() => {
        LinePainter.p.addOutput(this),
      },
    );
  }
}
class Pair {
  OutputConnectorState? output;
  InputConnectorState? input;
  Pair.empty();
  Pair.withInput(this.input);
  Pair.withOutput(this.output);
  void addOutput(OutputConnectorState output){
    this.output = output;
    checkDouble();
  }
  void addInput(InputConnectorState input){
    this.input = input;
    checkDouble();
  }
  void checkDouble(){
    if (output != null && input != null && input!.widget.connectedNode != output!.widget.connectedNode){
      if (!output!.widget.connectedInputs.contains(input!.widget)){
        connect();
      }
    }
  }
  void connect(){
    output!.connect(input!.widget);
    output = null;
    input = null;
    NodeWall.updateState();
  }
}