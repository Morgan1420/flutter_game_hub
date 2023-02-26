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
  bool gameOver = false;

  List<List<String>> matrix = [];
  List<List<bool>> matrixDescobertes = [];
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
              rowBuild(10),
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
          color: getButtonColor(x, y),
          border: Border.all(
            color: getButtonColor(x, y),
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
              unmaskButton(x, y);
            } else if (!gameOver && !matrixDescobertes[x][y]) {
              unmaskButton(x, y);
            }
          });
        },
        onLongPress: () {
          setState(() {
            if (gameStarted && !gameOver && !matrixDescobertes[x][y]) {
              matrixDescobertes[x][y] = true;
              matrix[x][y] = "F";
            }
          });
        },
        // fill
        child: Text(
          matrix[x][y],
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  // --------------------------------------- DISSENY GRÀFIC
  //  constructor de files de botons
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

  // Colors dels botons
  Color getButtonColor(int x, int y) {
    Color colorDefinitiu = Colors.blue;

    if (matrixDescobertes[x][y] == true) {
      switch (matrix[x][y]) {
        case "":
          colorDefinitiu = Colors.grey;
          break;
        case "1":
          colorDefinitiu = Colors.green.shade400;
          break;
        case "2":
          colorDefinitiu = Colors.green.shade600;
          break;
        case "3":
          colorDefinitiu = Colors.green.shade800;
          break;
        case "4":
          colorDefinitiu = Colors.yellow.shade700;
          break;
        case "5":
          colorDefinitiu = Colors.yellow.shade900;
          break;
        case "6":
          colorDefinitiu = Colors.red.shade400;
          break;
        case "7":
          colorDefinitiu = Colors.red.shade700;
          break;
        case "8":
          colorDefinitiu = Colors.red.shade900;
          break;
        case "B":
          colorDefinitiu = Colors.black;
          break;
        case "F":
          colorDefinitiu = Colors.red.shade400;
          break;

        default:
      }
    }

    return colorDefinitiu;
  }

  // --------------------------------------- GAME START
  // funció que es crida al entrar a la pàgina (statefull widget)
  void setUpMatrix() {
    for (var i = 0; i < numOfRows; i++) {
      List<String> row = [];
      List<String> row2 = [];
      List<bool> rowDescobertes = [];
      for (var j = 0; j < numOfColumns; j++) {
        row.add("");
        row2.add("");
        rowDescobertes.add(false);
      }
      matrix.add(row);
      matrixsolucio.add(row2);
      matrixDescobertes.add(rowDescobertes);
    }
  }

  // funció que es crida al premer el primer botó
  void startGame(int xo, int yo) {
    // posem les bombes dins la matriu solució "millorar funció fent-la while o algo"
    for (var i = 0; i < numOfMines; i++) {
      var bombX = Random().nextInt(numOfRows - 1);
      var bombY = Random().nextInt(numOfColumns - 1);

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
          if (numVeinsBomba > 0) {
            matrixsolucio[i][j] = numVeinsBomba.toString();
          } else {
            matrixsolucio[i][j] = "";
          }
        }
      }
    }

    // mostrem el botó seleccionat
  }

  // mira tots els veins que son bombes
  int veinsBomba(int x, int y) {
    var numVeinsBomba = 0;

    // N
    if (x > 0) {
      // NW
      if (y > 0) {
        if (matrixsolucio[x - 1][y - 1] == "B") {
          numVeinsBomba++;
        }
      }

      // NE
      if (y < numOfColumns - 1) {
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
    if (y > 0) {
      if (matrixsolucio[x][y - 1] == "B") {
        numVeinsBomba++;
      }
    }

    // E
    if (y < numOfColumns - 1) {
      if (matrixsolucio[x][y + 1] == "B") {
        numVeinsBomba++;
      }
    }

    // S
    if (x < numOfRows - 1) {
      // SW
      if (y > 0) {
        if (matrixsolucio[x + 1][y - 1] == "B") {
          numVeinsBomba++;
        }
      }

      // SE
      if (y < numOfColumns - 1) {
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

  // --------------------------------------- GAME PLAY
  // es mostra el que hi ha a matriuSolució en una posició donada
  void unmaskButton(int x, int y) {
    matrixDescobertes[x][y] = true;
    matrix[x][y] = matrixsolucio[x][y];

    if (matrixsolucio[x][y] == "B") {
      gameOver = true;
    } else if (matrixsolucio[x][y] == "") {
      // mostra les del voltant
      unmaskNeighbours(x, y);
    }
  }

  // es fa unmaskButton de tots els botons adjecents a un que no s'hagin mostrat abans
  void unmaskNeighbours(int x, int y) {
    // N
    if (x != 0) {
      // NW
      if (y != 0) {
        if (matrixDescobertes[x - 1][y - 1] == false) {
          unmaskButton(x - 1, y - 1);
        }
      }

      // NE
      if (y != numOfColumns - 1) {
        if (matrixDescobertes[x - 1][y + 1] == false) {
          unmaskButton(x - 1, y + 1);
        }
      }

      // N
      if (matrixDescobertes[x - 1][y] == false) {
        unmaskButton(x - 1, y);
      }
    }

    // W
    if (y != 0) {
      if (matrixDescobertes[x][y - 1] == false) {
        unmaskButton(x, y - 1);
      }
    }

    // E
    if (y != numOfColumns - 1) {
      if (matrixDescobertes[x][y + 1] == false) {
        unmaskButton(x, y + 1);
      }
    }

    // S
    if (x != numOfRows - 1) {
      // SW
      if (y != 0) {
        if (matrixDescobertes[x + 1][y - 1] == false) {
          unmaskButton(x + 1, y - 1);
        }
      }

      // SE
      if (y != numOfColumns - 1) {
        if (matrixDescobertes[x + 1][y + 1] == false) {
          unmaskButton(x + 1, y + 1);
        }
      }

      // S
      if (matrixDescobertes[x + 1][y] == false) {
        unmaskButton(x + 1, y);
      }
    }
  }

  // es marcarà una zona com a vista
  void flagButton(int x, int y) {}
}
