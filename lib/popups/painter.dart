
import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/connector.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:functional_spreadsheet/popups/rc_node.dart';



class LinePainter extends CustomPainter {
  static LinePainter? currentPainter;
  static List<List<Connector>> lines = [];
  static Pair p = Pair.empty();

  LinePainter() {
    currentPainter = this;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0;
    final paint2 = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0;
    for (int i = lines.length - 1; i >= 0; i--) {
      if (NodeWall.children.contains(((lines[i][0]) as InputConnector).connectedNode) && NodeWall.children.contains(((lines[i][1]) as OutputConnector).connectedNode)) {
        canvas.drawLine(
          (lines[i][0] as InputConnector).connectedNode.getInputConnectorPosition(lines[i][0] as InputConnector),
          (lines[i][1] as OutputConnector).connectedNode.getOutputConnectorPosition(lines[i][1] as OutputConnector),
          
          inRange(SelectState.x, SelectState.y, lines[i][0] as InputConnector, lines[i][1] as OutputConnector) ? paint2 : paint,
        );
      } else {
        lines.removeAt(i);
      }
    }
  }
  static addLines(List<List<Connector>> lines_) {
    for (List<Connector> line in lines_) {
      if (!lines.contains(line)) {
        lines.add(line);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  static void deleteLine(double x, double y) {
    for (int i = lines.length - 1; i >= 0; i--) {
      if (inRange(x, y, lines[i][0] as InputConnector, lines[i][1] as OutputConnector)) {
        (lines[i][1] as OutputConnector).disconnect(lines[i][0] as InputConnector);
        //print((lines[i][1] as OutputConnector).connectedInputs);
        lines.removeAt(i);
        NodeWall.updateState();
      }
    }
  }
  static bool inRange(double x, double y, InputConnector inputC, OutputConnector outputC) {
    Offset input = inputC.connectedNode.getInputConnectorPosition(inputC);
    Offset output = outputC.connectedNode.getOutputConnectorPosition(outputC);
    // find the slope of the line
    double slope = (output.dy - input.dy) / (output.dx - input.dx);
    // find the y-intercept of the line
    double yIntercept = input.dy - slope * input.dx;
    // find the y value of the line at the x value of the click
    double yValue = slope * x + yIntercept + 20;
    // if the x value is within the bounds of the line, delete the line
    if (y > yValue - 15 && y < yValue + 15 && (x > input.dx && x < output.dx || x < input.dx && x > output.dx)) {
      return true;
    }
    return false;
  }
}