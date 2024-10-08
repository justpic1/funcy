import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/connector.dart';
import 'package:functional_spreadsheet/node_objects/node.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:signals/signals_flutter.dart';

import '../popups/painter.dart';


// ignore: must_be_immutable
class ReducerNode extends Node {
  @override
  late Signal<dynamic> signal = Signal<dynamic>(0);
  int inputCount;
  int outputCount;
  late List<InputConnector> inputConnectors = List.generate(inputCount, (index) => InputConnector());
  late List<OutputConnector> outputConnectors = List.generate(outputCount, (index) => OutputConnector(this));
  ReducerNode({
    super.key, 
    required super.id, 
    required super.position, 
    required super.label,
    required this.inputCount,
    required this.outputCount,

  });
  @override
  ReducerNodeState createState() => ReducerNodeState();
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
              (widget as ReducerNode).inputConnectors[i].build(),
                IgnorePointer(
                  child: CustomPaint(
                    foregroundPainter: LinePainter(lines: [
                      for (int j = 0; j < (widget as ReducerNode).inputConnectors[i].connectedOutputs.length; j++)
                        if ((widget as ReducerNode).inputConnectors[i].connected.watch(context))
                          [
                            const Offset(0, -10),
                            (widget as ReducerNode).inputConnectors[i].connectedOutputs[j].connectedNode.position.watch(context) - widget.position.watch(context) + const Offset(100, -10)
                          ],
                    ]),
                  ),
                ),
              if (i < (widget as ReducerNode).inputCount - 1)
                Container(
                  height: 120 / (widget as ReducerNode).inputCount,
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
    return Column(
      children: [
        for (int i = 0; i < (widget as ReducerNode).outputCount; i++)
          Column(
            children: [
              (widget as ReducerNode).outputConnectors[i].build(),
              if (i < (widget as ReducerNode).outputCount - 1)
                Container(
                  height: 120/(widget as ReducerNode).outputCount,
                  width: 0,
                  color: Colors.transparent,
                ),
            ],
          )

          
      ],
    );
  }

}

