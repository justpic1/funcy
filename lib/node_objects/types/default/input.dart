import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/data.dart';
import 'package:functional_spreadsheet/node_objects/connector.dart';
import 'package:functional_spreadsheet/node_objects/reducer.dart';

// ignore: must_be_immutable
class InputNode extends ReducerNode {

  InputNode({
    super.key, 
    required super.position, 
    super.label = 'Input',
    super.inputCount = 0, 
    super.outputCount = 1,
    }) {
      DataState.addNode(this);
  }
  @override
  InputNodeState createState() => InputNodeState();
  
  @override
  void run(int key) {
    signalKey = key;
    for (OutputConnector output in outputConnectors) {
      for (InputConnector input in output.connectedInputs) {
        input.connectedNode.run(signalKey);
        
      }
    }
    rs.update();
  }  
}
class InputNodeState extends ReducerNodeState {
  late InputNode widget2;
  @override
  void initState(){
    super.initState();
    widget2 = widget as InputNode;
    
  }
  @override
  Widget body() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
      child: Text(widget2.signal.toString(),
      ),
    );
  }

  @override
  void popup(BuildContext context){
      List<dynamic> value = [];
      Type type = dynamic;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 100,
            width: 300,
            child: Column(
              children: [
              Row(
                children: [
                  const Text('Node Label: '),
                  Expanded(
                  child: TextField(
                    controller: TextEditingController(text: widget2.label),
                    onChanged: (inputType) {
                      if (inputType.isNotEmpty) {
                        widget2.label = inputType;
                      }
                    },
                    
                    decoration: const InputDecoration(hintText: "Enter name"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Node Value: '),
                Expanded(
                child: TextField(
                  controller: TextEditingController(text: widget2.signal.toString().replaceAll('[', '').replaceAll(']', '')),
                  onChanged: (inputValue) {
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
                  },
                  decoration: const InputDecoration(hintText: "Enter value"),
                ),
              ),
            ],
          ),
          
        ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
          Navigator.of(context).pop();
          if (value.isNotEmpty) {
            widget2.signal = value;
            widget2.type = type;
          }
          update();
              },
            ),
          ],
        );
      },
    );
  }
}