import 'package:flutter/material.dart';
import './tictactoe.dart';

void main() {
  runApp(MainMenu());
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game HUB',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeMenu(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      body: Column(children: <Widget>[
        Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                buildButton("Tic-Tac-Toe", Colors.blue, 1, context),
                buildButton("Minesweeper", Colors.blue, 1, context),
              ],
            )),
      ]),
    );
  }

  Widget buildButton(String buttonText, Color buttonColor, double buttonHeight,
      BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      color: buttonColor,
      child: TextButton(
        onPressed: () {
          if (buttonText == "Tic-Tac-Toe") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TicTacToe()));
          }
        },
        child: Text(buttonText,
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
            )),
      ),
    );
  }
}
