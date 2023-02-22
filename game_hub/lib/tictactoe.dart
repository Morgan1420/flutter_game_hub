import 'dart:html';

import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TicTacToeState();
  }
}

class TicTacToeState extends State<TicTacToe> {
  // --- here are all the game variables
  List<List<String>> matrix = [
    [" ", " ", " "],
    [" ", " ", " "],
    [" ", " ", " "]
  ];
  String torn = "X";

  // --- Widget builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tic-Tac-Toe")),
      body: Column(children: <Widget>[
        Expanded(
          child: Divider(color: Colors.transparent),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              buildButton(context, 0, 0),
              buildButton(context, 0, 1),
              buildButton(context, 0, 2)
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              buildButton(context, 1, 0),
              buildButton(context, 1, 1),
              buildButton(context, 1, 2)
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              buildButton(context, 2, 0),
              buildButton(context, 2, 1),
              buildButton(context, 2, 2)
            ],
          ),
        ),
        Expanded(
          child: Divider(color: Colors.transparent),
        ),
      ]),
    );
  }

  Widget buildButton(BuildContext context, var x, var y) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.33333,
      height: MediaQuery.of(context).size.height * 0.15,
      child: TextButton(
        onPressed: () {
          setState(() {
            // mirem si està buida la posició
            if (matrix[x][y] == " ") {
              matrix[x][y] = torn;
            }

            // canvi de jugador
            if (torn == "X") {
              torn = "O";
            } else {
              torn = "X";
            }
          });
        },
        child: Text(matrix[x][y]),
      ),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black,
        width: MediaQuery.of(context).size.width * 0.0001,
      )),
    );
  }
}
