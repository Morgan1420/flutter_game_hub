import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  @override
  TicTacToeState createState() => TicTacToeState();
}

class TicTacToeState extends State<TicTacToe> {
  // --- here are all the game variables
  List<List<String>> matrix = [
    [" ", " ", " "],
    [" ", " ", " "],
    [" ", " ", " "]
  ];
  String torn = "X", victoryText = "Torn de les X";
  bool gameOver = false;
  final TORNS_MAXIMS = 9;
  int numTorns = 0;
  Map signColors = {'X': Colors.red, 'O': Colors.black};
  // --- Widget builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tic-Tac-Toe")),
      body: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(0, 70, 0, 50),
          child: Text(
            victoryText,
            style: TextStyle(fontSize: 35, color: signColors[torn]),
          ),
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
        const Expanded(
          child: Divider(color: Colors.transparent),
        ),
      ]),
    );
  }

  Widget buildButton(BuildContext context, var x, var y) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.33333,
        height: MediaQuery.of(context).size.width * 0.33333,
        decoration: BoxDecoration(
            border: Border.all(
          color: signColors[torn],
          width: MediaQuery.of(context).size.width * 0.002,
        )),
        child: TextButton(
          style: TextButton.styleFrom(
              minimumSize:
                  Size.square(MediaQuery.of(context).size.width * 0.33333)),
          onPressed: () {
            setState(() {
              if (!gameOver) {
                // mirem si està buida la posició
                if (matrix[x][y] == " ") {
                  matrix[x][y] = torn;

                  // Mirem si s'ha acabat el joc
                  EndGameConditions();

                  numTorns++;
                  // cambiem torn si no s'ha acabat el joc
                  if (!gameOver) {
                    // canvi de jugador
                    if (torn == "X") {
                      torn = "O";
                    } else {
                      torn = "X";
                    }
                    // canviem el indicador de torn
                    victoryText = "Torn de les " + torn;
                  }
                }

                if (gameOver) {
                  victoryText = "Guanyen les " + torn + " !!!";
                } else if (numTorns == TORNS_MAXIMS) {
                  victoryText = "Empat!!!";
                }
              }
            });
          },
          child: Text(
            matrix[x][y],
            style: TextStyle(fontSize: 50, color: signColors[matrix[x][y]]),
          ),
        ));
  }

  void EndGameConditions() {
    if (matrix[0][0] == torn && matrix[0][1] == torn && matrix[0][2] == torn) {
      gameOver = true;
    } else if (matrix[1][0] == torn &&
        matrix[1][1] == torn &&
        matrix[1][2] == torn) {
      gameOver = true;
    } else if (matrix[2][0] == torn &&
        matrix[2][1] == torn &&
        matrix[2][2] == torn) {
      gameOver = true;
    } else if (matrix[0][0] == torn &&
        matrix[1][0] == torn &&
        matrix[2][0] == torn) {
      gameOver = true;
    } else if (matrix[0][1] == torn &&
        matrix[1][1] == torn &&
        matrix[2][1] == torn) {
      gameOver = true;
    } else if (matrix[0][2] == torn &&
        matrix[1][2] == torn &&
        matrix[2][2] == torn) {
      gameOver = true;
    } else if (matrix[0][0] == torn &&
        matrix[1][1] == torn &&
        matrix[2][2] == torn) {
      gameOver = true;
    } else if (matrix[0][2] == torn &&
        matrix[1][1] == torn &&
        matrix[2][0] == torn) {
      gameOver = true;
    }
  }
}
