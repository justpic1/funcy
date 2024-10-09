import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/node_wall.dart';
import 'package:signals/signals.dart';

// ignore: must_be_immutable
abstract class Node extends StatefulWidget {
  int id;
  Signal<Offset> position;
  String label;
  Node({
    super.key,
    required this.id, 
    required this.position,
    required this.label,
  });

  
}

abstract class NodeState extends State<Node> {
  @override
  void initState() {
    NodeWall.states.add(this);
    super.initState();
  }
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
    setState(
      () {widget.position.set(widget.position.value + const Offset(.00000000000001, .0000000000001));}
    );
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
            onDoubleTap: (){
              setState(() {
                NodeWall.removeNode(widget);
                 
              });
            },
            onPanUpdate: (details) => setState(() {
              widget.position.set(Offset(
                widget.position.value.dx + details.delta.dx,
                widget.position.value.dy + details.delta.dy,
              ));
            }),
            child: ConstrainedBox(constraints: 
              BoxConstraints.tight(const Size(100, 150)),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    padding: const EdgeInsets.all(2.0),
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
                            fontSize: 12,
                          ),
                        ),
                  ),
                    Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
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
      padding: const EdgeInsets.all(8.0),
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