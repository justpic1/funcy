import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/data.dart';
import 'package:functional_spreadsheet/node_objects/connector.dart';
import 'package:functional_spreadsheet/node_objects/node.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:functional_spreadsheet/node_objects/types/default/input.dart';


// ignore: must_be_immutable
class ReducerNode extends Node {
  late ReducerNodeState rs;
  Type type = int;
  late List<dynamic> signal = [];
  late int signalKey = 0;
  int inputCount;
  int outputCount;
  late List<InputConnector> inputConnectors = List.generate(inputCount, (index) => InputConnector(this));
  late List<OutputConnector> outputConnectors = List.generate(outputCount, (index) => OutputConnector(this));
  ReducerNode({
    super.key, 
    required super.position, 
    required super.label,
    required this.inputCount,
    required this.outputCount, 
  });
  ReducerNode.withSignal({
    super.key, 
    required super.position, 
    required super.label,
    required this.inputCount,
    required this.outputCount,
    required this.signal,
  });
  void run(int key) {
    /*
    print("NO");
    // check if all input connector keys are the same
    if ((inputConnectors.map((element) => element.connectedNode.signalKey.value).toSet().length == 1)) {
      // run the reducer function
      signal = (signal + 1);
      // update the node rendering
      rs.update();
    }
    for (OutputConnector output in outputConnectors) {
      for (InputConnector input in output.connectedInputs) {
        input.connectedNode.run(signal);
      }
    }
    */
  }
  @override
  void setVal(dynamic value, String variableName){
    if (variableName == 'inputCount') {
      inputCount = value;
    }
    if (variableName == 'outputCount') {
      outputCount = value;
    }
    if (variableName == 'signal') {
      signal = value;
    }
    super.setVal(value, variableName);
    rs.update();
  }

  @override
  ReducerNodeState createState() => ReducerNodeState();

  Offset getInputConnectorPosition(InputConnector input) {
  return Offset(
    position.value.dx + 5,
    // account for the fact that the input connectors are spaced out vertically and aligned to the center of the node
    position.value.dy + calculateSquarePosition(inputConnectors.indexOf(input), inputCount) + 15,
  );
  }

  Offset getOutputConnectorPosition(OutputConnector output) {
    return Offset(
      position.value.dx + 105,
      // account for the fact that the output connectors are spaced out vertically and aligned to the center of the node
      position.value.dy + calculateSquarePosition(outputConnectors.indexOf(output), outputCount) + 15,
    );
  }
  double calculateSquarePosition(int squareIndex, int numSquares, {double squareHeight = 20, double spacing = 10, double centerX = 70}) {
    // Total height of the entire row of squares
    double totalRowHeight = numSquares * squareHeight + (numSquares - 1) * spacing;

    // Find the leftmost point of the row by centering it on the centerX
    double leftmostPoint = centerX - totalRowHeight / 2;

    // Calculate the position of the square
    double position = leftmostPoint + squareIndex * (squareHeight + spacing);

    return position;
  }
}
class ReducerNodeState extends NodeState {
  @override
  void initState() {
    super.initState();
    NodeWall.states.add(this);
    ReducerNode widget2 = widget as ReducerNode;
    widget2.rs = this;
  }
  @override
  Widget body() {
    
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
      child: Text((widget as ReducerNode).signal.toString()
      ),
    );
  }
  @override
  Column inputs() {
    return Column(
      children: [
        for (int i = 0; i < (widget as ReducerNode).inputCount; i++)
          Column(
            children: [
              (widget as ReducerNode).inputConnectors[i],
              if (i < (widget as ReducerNode).inputCount - 1)
                Container(
                  height: 10,
                  width: 0,
                  color: Colors.transparent,
                ),
            ],
          )

          
      ],
    );
  }
  @override
  Column outputs() {
    
    //print(LinePainter.lines);
    return Column(
      children: [
        
          Column(
            children: [
              for (int i = 0; i < (widget as ReducerNode).outputCount; i++) ...[
                (widget as ReducerNode).outputConnectors[i],
                if (i < (widget as ReducerNode).outputCount - 1)
                  Container(
                    height: 10,
                    width: 0,
                    color: Colors.transparent,
                  ),
              ],
            ],
          )

          
      ],
    );
  }
  @override
  void popup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reducer Node'),
          content: TextField(
            onChanged: (value) {
              // Handle input change
            },
            decoration: const InputDecoration(hintText: "Enter value"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void deleteNode(){ 
    if (NodeWall.children.whereType<InputNode>().length == 1 && widget is InputNode) {
      // Replace this node with another node
      NodeWall.addNode(InputNode(position: widget.position, outputCount: 1));
      // popup dialog to state that the last input node cannot be deleted
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
        title: const Text('Warning'),
        content: const Text('The last input node cannot be deleted.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
          Navigator.of(context).pop();
            },
          ),
        ],
          );
        },
      );
    }
    for (InputConnector input in (widget as ReducerNode).inputConnectors) {
      List<OutputConnector> connectedOutputsCopy = List.from(input.connectedOutputs);
      // Iterate over the copy and perform the disconnection
      for (OutputConnector output in connectedOutputsCopy) {
        output.disconnect(input);
      }
    }
    for (OutputConnector output in (widget as ReducerNode).outputConnectors) {
      List<InputConnector> connectedInputsCopy = List.from(output.connectedInputs);
      // Iterate over the copy and perform the disconnection
      for (InputConnector input in connectedInputsCopy) {
        output.disconnect(input);
      }
    }
    DataState.deleteNode((widget as ReducerNode));
    super.deleteNode();
  }
}

