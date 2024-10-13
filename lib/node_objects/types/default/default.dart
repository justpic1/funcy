import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/types/function.dart';

import 'package:signals/signals.dart';
class DefaultNodes {
  static FunctionNode sum(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'SUM',
      types: const [List<int>],
      function: (List<List<dynamic>> inputs) {
        return 
      inputs.expand((i) => i).reduce((a, b) => a + b);
      }, 
    );
  }
}