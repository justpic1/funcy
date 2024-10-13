import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/data.dart';
import 'package:pluto_grid/pluto_grid.dart';

// ignore: must_be_immutable
class Sheet extends StatelessWidget {
  Sheet({super.key});
  late Data pg = const Data();
  @override
  Widget build(BuildContext context) {
    return pg;

  }
  static PlutoGrid defaultGen(){
    return PlutoGrid(
    columns: [
      PlutoColumn(
        title: 'Column A',
        field: 'column_a',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Column B',
        field: 'column_b',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Column C',
        field: 'column_c',
        type: PlutoColumnType.text(),
      ),
    ],
    rows: [
      PlutoRow(
        cells: {
          'column_a': PlutoCell(value: 'A1'),
          'column_b': PlutoCell(value: 'B1'),
          'column_c': PlutoCell(value: 'C1'),
        },
      ),
      PlutoRow(
        cells: {
          'column_a': PlutoCell(value: 'A2'),
          'column_b': PlutoCell(value: 'B2'),
          'column_c': PlutoCell(value: 'C2'),
        },
      ),
      PlutoRow(
        cells: {
          'column_a': PlutoCell(value: 'A3'),
          'column_b': PlutoCell(value: 'B3'),
          'column_c': PlutoCell(value: 'C3'),
        },
      ),
    ],
  );
  }
}