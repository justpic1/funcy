import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/connector.dart';
import 'package:functional_spreadsheet/node_objects/node.dart';
import 'package:signals/signals_flutter.dart';


// ignore: must_be_immutable
class ReducerNode extends Node {
  late Signal<dynamic> signal = Signal<dynamic>(0);
  late Signal<int> signalKey = Signal<int>(0);
  int inputCount;
  int outputCount;
  late List<InputConnector> inputConnectors = List.generate(inputCount, (index) => InputConnector(this));
  late List<OutputConnector> outputConnectors = List.generate(outputCount, (index) => OutputConnector(this));
  ReducerNode({
    super.key, 
    required super.id, 
    required super.position, 
    required super.label,
    required this.inputCount,
    required this.outputCount,

  });
  void run(int key) {
    // check if all input connector keys are the same
    if (inputConnectors.every((element) => element.connectedNode.signalKey.value == key)) {
      // run the reducer function
      signal.set(inputConnectors.map((e) => e.connectedNode.signal.value).toList());
    }
    
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
  Widget body() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
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


}

