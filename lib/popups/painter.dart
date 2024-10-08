
import 'package:flutter/material.dart';



class LinePainter extends CustomPainter {
  List<List<Offset>> lines;
  static List<LinePainter> painters = [];


  LinePainter({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    painters.add(this);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0;

    for (final line in lines) {
      canvas.drawLine(line[0], line[1], paint);
    }
  }
  setLines(List<List<Offset>> lines) {
    this.lines = lines;
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}