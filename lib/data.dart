
import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/node.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';
import 'package:functional_spreadsheet/node_objects/types/default/input.dart';
import 'package:functional_spreadsheet/node_objects/types/default/output.dart';
import 'package:functional_spreadsheet/pages/sheetpage.dart';
import 'package:pluto_grid/pluto_grid.dart';


class Data extends StatefulWidget {
  const Data({super.key});

  @override
  DataState createState() => DataState();
  

}

class DataState extends State<Data> {
  static List<List<ReducerNode>> nodes = [];
  static List<List<dynamic>> data = [[]];
  static void deleteNode(ReducerNode node) {
    for (int i = 0; i < nodes.length; i++) {
      for (int j = 0; j < nodes[i].length; j++) {
        if (nodes[i][j] == node) {
          nodes[i].removeAt(j);
          if (nodes[i].isEmpty) {
            nodes.removeAt(i);
            return;
          }
        }
      }
    }
  }
  static void addNode(ReducerNode node) {
    nodes.add([node]);
  }
  static List<List<dynamic>> getData() {
    return data;
  }

  void addData(String d, int location) {
    setState(() {
      data.add([d]);
    });
  }

  void removeData(List<dynamic> d) {
    setState(() {
      data.remove(d);
    });
  }

  void clearData() {
    setState(() {
      data.clear();
    });
  }

  void setData(List<List<String>> d) {
    setState(() {
      data = d;
    });
  }

  @override
  void initState() {
    super.initState();
    data = transform(nodes);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: LayoutBuilder(
        builder: (context, constraint) {
          if (constraint.maxWidth == 0) {
            return Container();
          }
          return PlutoGrid(

            onChanged: (event) => setState(() {
              editNode(event);
              data[event.rowIdx+1][event.columnIdx] = event.value+'-'+data[event.rowIdx+1][event.columnIdx].toString().split('-')[1]+'-'+data[event.rowIdx+1][event.columnIdx].toString().split('-')[2];
              NodeWall.run();
              updateData();
            }),
            columns: [
              
              if (data.isEmpty || data[0].isEmpty)
                PlutoColumn(
                  title: '',
                  field: '',
                  type: PlutoColumnType.text(),
                  readOnly: true,
                  backgroundColor: Colors.grey,
                )
              else
              for (int i = 0; i < data[0].length; i++)
                
                parseColumn(data[0][i].toString()),

            ],
            rows: [
              
                if (data.isEmpty || data[0].isEmpty)
                PlutoRow(
                  cells: {
                    '': PlutoCell(value: '')
                  },
                )
                else
              for (int i = 1; i < data.length; i++)
                parseRow(data[i]),
            ],
          );
        },
      ),
    );
  }
static List<List<dynamic>> transform(List<List<ReducerNode>> input) {
  if (input.isEmpty || input[0][0].signal.isEmpty) {
    return [];
  }
  List<List<dynamic>> output = [];

  // Create a list to gather all signals
  List<dynamic> allSignals = [];

  // Iterate over the input and gather signals into a single list
  for (int row = 0; row < input.length; row++) {
    allSignals.clear(); // Clear the list before adding new signals
    for (var obj in input[row]) {
      // Add all signals from each MyObject with a unique identifier
      for (int i = 0; i < obj.signal.length; i++) {
        allSignals.add('${obj.signal[i]}-${NodeWall.children.indexOf(obj)}-$i');
      }
    }
    
    for (var i = 0; i < allSignals.length; i++) {
      if (output.length <= i) {
        output.add([]); // Add a new list if it doesn't exist
      }
      if (output[i].length < row) {
        output[i].addAll(List.filled(row - output[i].length, '')); // Fill with nulls if the row is missing
      }
      output[i].add(allSignals[i]); // Add the signal to the output
    }
  }
  // Ensure all rows in the output have the same length
  int maxLength = output.map((e) => e.length).reduce((a, b) => a > b ? a : b);
  for (var row in output) {
    while (row.length < maxLength) {
      row.add('');
    }
  }
  output.insert(0, [for (int i = 0; i < maxLength; i++) 'abcdefghijklmnopqrstuvwxyz'[i]]);
  return output;
}
  PlutoColumn parseColumn(dynamic d) {
    return PlutoColumn(
      title: d.toString(),
      field: d.toString(),
      type: PlutoColumnType.text(),
      readOnly: d == '=Output',
      backgroundColor: d == '=Output' ? Colors.grey : Colors.white,
    );
  }

  PlutoRow parseRow(List<dynamic> d) {
    return PlutoRow(
      cells: {
        for (int i = 0; i < d.length; i++)
            data[0][i].toString(): PlutoCell(value: d[i].toString().split('-')[0])
      },
    );
  }
  void editNode(event) {
    int nodeIndex = int.parse(data[event.rowIdx + 1][event.columnIdx].toString().split('-')[1]);
    int signalIndex = int.parse(data[event.rowIdx + 1][event.columnIdx].toString().split('-')[2]);
    ReducerNode node = NodeWall.children[nodeIndex];
    if (node is OutputNode) {
      return;
    }
    dynamic value;
    Type type = List<String>;
    if (node is InputNode) {
      String inputValue = node.signal.map((e) => node.signal.indexOf(e) == signalIndex ? event.value : e).join(',');

      try {
          if (inputValue.replaceAll(' ', '').split(',').every((element) => element == 'true' || element == 'false')) {
      value = inputValue.replaceAll(' ', '').split(',').map((e) => e == 'true').toList();
      type = List<bool>;
          }
          else if (inputValue.replaceAll(' ', '').split(',').every((element) => int.tryParse(element) != null)) {
      value = inputValue.replaceAll(' ', '').split(',').map((e) => int.parse(e)).toList();
      type = List<int>;
          }
          else if (inputValue.replaceAll(' ', '').split(',').every((element) => double.tryParse(element) != null)) {
      value = inputValue.replaceAll(' ', '').split(',').map((e) => double.parse(e)).toList();
      type = List<double>;
          }
          else {
      value = inputValue.split(',');
      type = List<String>;
          }
        } catch (e) {
          value = [];
        }
      node.signal = value;
      node.type = type;
  }
}

  void updateData() {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SheetPage()));
  }
}
