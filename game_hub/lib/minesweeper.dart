import 'dart:math';
import 'package:flutter/material.dart';

class Minesweeper extends StatefulWidget {
  @override
  MinesweeperState createState() => MinesweeperState();
}

class MinesweeperState extends State<Minesweeper> {
  final numOfRows = 20;
  final numOfColumns = 12;
  final numOfMines = 40;

  bool gameStarted = false;
  List<List<String>> matrix = [];
  List<List<String>> matrixsolucio =
      []; // B = bomba, E = empty, num = num bombes adjecents

  @override
  Widget build(BuildContext context) {
    setUpMatrix();
    return Scaffold(
        appBar: AppBar(title: const Text("Minesweeper")),
        body: InteractiveViewer(
          child: Column(
            children: <Widget>[
              const Expanded(
                child: Divider(color: Colors.transparent),
              ),
              rowBuild(0),
              rowBuild(1),
              rowBuild(2),
              rowBuild(3),
              rowBuild(4),
              rowBuild(5),
              rowBuild(6),
              rowBuild(7),
              rowBuild(8),
              rowBuild(9),
              rowBuild(11),
              rowBuild(12),
              rowBuild(13),
              rowBuild(14),
              rowBuild(15),
              rowBuild(16),
              rowBuild(17),
              rowBuild(18),
              rowBuild(19),
              const Expanded(
                child: Divider(color: Colors.transparent),
              ),
            ],
          ),
        ));
  }

  Widget minesButton(int x, int y) {
    // aquí guardarem la id de cada botó
    int buttonX = x, buttonY = y;
    return Container(
      // mides
      width: MediaQuery.of(context).size.width / (numOfColumns + 2),
      height: MediaQuery.of(context).size.width / (numOfColumns + 2),
      // decoració i estils
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width * 0.001,
          )),
      // fill button
      child: TextButton(
        // estil
        style: TextButton.styleFrom(
          minimumSize: Size.square(
              MediaQuery.of(context).size.width / (numOfColumns + 2)),
        ),
        // funció al premer
        onPressed: () {
          setState(() {
            if (!gameStarted) {
              startGame(x, y);
              gameStarted = true;
            }
          });
        },
        // fill
        child: Text(
          matrixsolucio[x][y],
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  Widget rowBuild(int row) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Colors.transparent),
        ),
        minesButton(row, 0),
        minesButton(row, 1),
        minesButton(row, 2),
        minesButton(row, 3),
        minesButton(row, 4),
        minesButton(row, 5),
        minesButton(row, 6),
        minesButton(row, 7),
        minesButton(row, 8),
        minesButton(row, 9),
        minesButton(row, 10),
        minesButton(row, 11),
        const Expanded(
          child: Divider(color: Colors.transparent),
        ),
      ],
    );
  }

  void setUpMatrix() {
    for (var i = 0; i < numOfRows; i++) {
      List<String> row = [];
      for (var j = 0; j < numOfColumns; j++) {
        row.add("");
      }
      matrix.add(row);
      matrixsolucio.add(row);
    }
  }

  void startGame(int xo, int yo) {
    // posem les bombes dins la matriu solució "millorar funció fent-la while o algo"
    for (var i = 0; i < numOfMines; i++) {
      var bombX = Random().nextInt(numOfRows);
      var bombY = Random().nextInt(numOfColumns);

      if (matrixsolucio[bombX][bombY] == "" &&
          !(bombX >= xo - 1 &&
              bombX <= xo + 1 &&
              bombY >= yo - 1 &&
              bombY <= yo + 1)) {
        matrixsolucio[bombX][bombY] = "B";
      } else {
        i--;
      }
    }

    // asignem els numeros corresponents als veins de les bombes i els empties
    for (var i = 0; i < numOfRows; i++) {
      for (var j = 0; j < numOfColumns; j++) {
        if (matrixsolucio[i][j] != "B") {
          var numVeinsBomba = veinsBomba(i, j);
          if (numVeinsBomba != 0) {
            matrixsolucio[i][j] = numVeinsBomba.toString();
          } else {
            matrixsolucio[i][j] = "";
          }
        }
      }
    }
  }

  int veinsBomba(int x, int y) {
    var numVeinsBomba = 0;

    // N
    if (x != 0) {
      // NW
      if (y != 0) {
        if (matrixsolucio[x - 1][y - 1] == "B") {
          numVeinsBomba++;
        }
      }

      // NE
      if (y != numOfColumns - 1) {
        if (matrixsolucio[x - 1][y + 1] == "B") {
          numVeinsBomba++;
        }
      }

      // N
      if (matrixsolucio[x - 1][y] == "B") {
        numVeinsBomba++;
      }
    }

    // W
    if (y != 0) {
      if (matrixsolucio[x][y - 1] == "B") {
        numVeinsBomba++;
      }
    }

    // E
    if (y != numOfColumns - 1) {
      if (matrixsolucio[x][y + 1] == "B") {
        numVeinsBomba++;
      }
    }

    // S
    if (x != numOfRows - 1) {
      // SW
      if (y != 0) {
        if (matrixsolucio[x + 1][y - 1] == "B") {
          numVeinsBomba++;
        }
      }

      // SE
      if (y != numOfColumns - 1) {
        if (matrixsolucio[x + 1][y + 1] == "B") {
          numVeinsBomba++;
        }
      }

      // S
      if (matrixsolucio[x + 1][y] == "B") {
        numVeinsBomba++;
      }
    }

    return numVeinsBomba;
  }
}
