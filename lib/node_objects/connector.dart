import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/node.dart';
import 'package:functional_spreadsheet/theme.dart';
import 'package:signals/signals.dart';

abstract class Connector {
  late Signal signal;
  late Color color;
  Container build(){
    return Container(
      height: 20,
      width: 10,
      color: color,
      child: GestureDetector(
        onTap:(){
          
        } ,),
    );
  }
}
class InputConnector extends Connector {
  Signal<bool> connected = Signal(false);
  List<OutputConnector> connectedOutputs = [];
  InputConnector(){
    color = MyTheme.currentMyTheme.input;
  }
  void connect(OutputConnector output){
    connected.value = true;
    connectedOutputs.add(output);
  }
}
class OutputConnector extends Connector {
  Node connectedNode;
  OutputConnector(this.connectedNode){
    color = MyTheme.currentMyTheme.output;
  }
  void connect(InputConnector input){
    input.connected.value = true;
    input.connectedOutputs.add(this);
  }
}