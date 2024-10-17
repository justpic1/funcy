import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/actions.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:functional_spreadsheet/pages/nodepage.dart';
import 'package:signals/signals.dart';

// ignore: must_be_immutable
abstract class Node extends StatefulWidget {
  Signal<Offset> position;
  String label;
  Node({
    super.key,
    required this.position,
    required this.label,
  });
    void setVal(dynamic value, String variableName){
    if (variableName == 'create') {
      NodeWall.removeNode(this);
    }
    if (variableName == 'delete') {
      NodeWall.addNode(this);
    }
    if (variableName == 'position') {
      position.set(value);
    }
    
  }
}

abstract class NodeState extends State<Node> {
  Offset? startValue;
  @override
  void dispose() {
    NodeWall.states.remove(this);
    super.dispose();
  }
  void move(Offset position) {
    setState(() {
      widget.position.set(position);
    });
  }
  void update() {
    if (!mounted) {
      return;
    }
    setState(
      () {widget.position.set(widget.position.value + const Offset(.00000000000001, .0000000000001));}
    );
  }
  void deleteNode() {
    NodeWall.states.remove(this);
    NodeWall.removeNode(widget);
    
  }
  void popup(BuildContext context){
    // ignore: avoid_print
    print('popup');
  }

  @override
  Widget build(BuildContext context) {
    
    return Positioned(
      left: widget.position.value.dx,
      top: widget.position.value.dy,
      child: Row(
        children: [
          inputs(),
          GestureDetector(
            onTap: () {
              popup(context);
            },
            onDoubleTap: (){
              setState(() {
                deleteNode();
              });
            },
            /*
            onPanStart: (details) => setState(() {
              startValue = widget.position.value;
              print(startValue);
            }),
            */
            onPanUpdate: (details) => setState(() {
              widget.position.set(Offset(
                widget.position.value.dx + details.delta.dx,
                widget.position.value.dy + details.delta.dy,
              ));
            }),
            /*
            onPanEnd: (details) => setState(() {
              NodePage.actions.addAction(MyAction(widget, startValue, widget.position.value, 'position'));
            }),
            */
            child: ConstrainedBox(constraints: 
              BoxConstraints.tight(const Size(110, 150)),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    padding: const EdgeInsets.all(0.2),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                          widget.label,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                  ),
                    Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: body(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          outputs(),
        ],
      ),
    );
  }

  Column inputs() {
    return const Column();
  }
  Column outputs() {
    return const Column();
  }
  Widget body(){
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: const Center(
        
      ),
    );
  }
}