import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';
import 'package:functional_spreadsheet/popups/painter.dart';
import 'package:functional_spreadsheet/theme.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

// ignore: must_be_immutable
abstract class Connector extends StatefulWidget {
  late Signal signal;
  late Color color;

  Connector({super.key});
}
// ignore: must_be_immutable
class InputConnector extends Connector {
  ReducerNode connectedNode;
  InputConnector(this.connectedNode, {super.key}){
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
  ReducerNode connectedNode;
  List<InputConnector> connectedInputs = [];
  
  OutputConnector(this.connectedNode, {super.key}){
    color = MyTheme.currentMyTheme.output;
  }
  void disconnect(InputConnector input){
    connectedInputs.remove(input);
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