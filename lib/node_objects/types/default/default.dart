import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/function.dart';
import 'package:signals/signals.dart';
class DefaultNodes {
  static FunctionNode sum(Offset position, inputCount) {
    return FunctionNode(
      id: 0,
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'SUM',
      function: (inputs) => [inputs.fold(0, (a, b) => a + b)],
      inputs: List.generate(inputCount, (index) => [0]),
    );
  }
}