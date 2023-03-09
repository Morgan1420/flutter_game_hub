import 'package:flutter/material.dart';
import 'dart:math';

class Sudoku extends StatefulWidget {
  @override
  SudokuState createState() => SudokuState();
}

class SudokuState extends State<Sudoku> {
  // constants
  final MATRIX_SIZE = 9;
  final BOX_SIZE = 3;
  final NUMBER_OF_BOXES = 9;
  // variables sudoku globals
  SudokuBlueprint sudokuSolucio = SudokuBlueprint(true);
  SudokuBlueprint sudokuJugador = SudokuBlueprint(false);
  // build function
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sudoku")),
      body: Column(children: [buildMatrix(), buildIndexRow()]),
    );
  }

  // --------------------------------- Sudoku matrix
  // build button
  Widget buildMatrixButton(int x, int y) {
    int buttonX, buttonY;
    return Container(
      // mides
      width: MediaQuery.of(context).size.width / (MATRIX_SIZE + 2),
      height: MediaQuery.of(context).size.width / (MATRIX_SIZE + 2),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 0.05)),

      child: TextButton(
          // estil
          style: TextButton.styleFrom(
            minimumSize: Size.square(
                MediaQuery.of(context).size.width / (MATRIX_SIZE + 2)),
          ),
          onPressed: null,
          child: Text(sudokuSolucio.getPos(x, y))),
    );
  }

  // build sudoku row
  Widget buildMatrixButtonRow(int row) {
    return Row(
      children: [
        buildMatrixButton(row, 0),
        buildMatrixButton(row, 1),
        buildMatrixButton(row, 2),
        const VerticalDivider(
          indent: 10,
        ),
        buildMatrixButton(row, 3),
        buildMatrixButton(row, 4),
        buildMatrixButton(row, 5),
        const VerticalDivider(
          indent: 10,
          thickness: 5,
        ),
        buildMatrixButton(row, 6),
        buildMatrixButton(row, 7),
        buildMatrixButton(row, 8)
      ],
    );
  }

  // build sudoku matrix
  Widget buildMatrix() {
    return Column(
      children: [
        buildMatrixButtonRow(0),
        buildMatrixButtonRow(1),
        buildMatrixButtonRow(2),
        const Divider(
          thickness: 1,
          indent: 0,
        ),
        buildMatrixButtonRow(3),
        buildMatrixButtonRow(4),
        buildMatrixButtonRow(5),
        const Divider(
          indent: 10,
        ),
        buildMatrixButtonRow(6),
        buildMatrixButtonRow(7),
        buildMatrixButtonRow(8)
      ],
    );
  }

  // --------------------------------- index buttons
  Widget buildIndexButton() {
    return Container();
  }

  Widget buildIndexRow() {
    return Row();
  }
}

// -------------------------------------------------------------------------------------------------------------- classe sudoku, on passa tota la màgia
class SudokuBlueprint {
  // constants
  final MATRIX_SIZE = 9;
  final BOX_SIZE = 3;
  final NUMBER_OF_BOXES = 9;

  List<List<String>> m_matriu = [];
  Map m_boxIndicator = {
    0: [0, 0],
    1: [0, 3],
    2: [0, 6],
    3: [3, 0],
    4: [3, 3],
    5: [3, 6],
    6: [6, 0],
    7: [6, 3],
    8: [6, 6],
  };

  // constructor de la matriu
  SudokuBlueprint(bool solucio) {
    // inicialitzem la matriu a 0
    initMatriuZeros();
    if (solucio) {
      // omplir els boxs de la matriu amb numeros random de l'1 al 9 (sense repetir)
      fillBoxes();
      // ordenar les files tenint en compte les columnes, d'esquerra a dreta si n'hi ha algun repetit o que no cumpleix condicions el cambiem per unn de la box que si les cumpleixi
    } else {}
  }

  // -+-+-+-+-+-+-+-+-+ funcions del build
  // omple les boxes de la matriu amb numeros random de l'1 al 9 (sense repetir)
  void fillBoxes() {
    for (var b = 0; b < NUMBER_OF_BOXES; b++) {
      List<String> availableNums = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9"
      ];
      for (var c = 0; c < BOX_SIZE; c++) {
        for (var r = 0; r < BOX_SIZE; r++) {
          var randNum = Random().nextInt(availableNums.length);
          m_matriu[m_boxIndicator[b][0] + c][m_boxIndicator[b][1] + r] =
              availableNums[randNum];
          availableNums.remove(availableNums[randNum]);
        }
      }
    }
  }

  // ordenar les files de la matriu tenint en compte les columnes i la mateixa
  void sortMatrix() {
    for (var r = 0; r < MATRIX_SIZE; r++) {
      var numCanvis = 0;
      for (var c = 0; c < MATRIX_SIZE; c++) {
        if (igualEsquerra(r, c)) // mirar esquerra a veure si hi ha una igual
        {
          cambiaEsquerra(r, c);
        } else if (igualAmunt(r, c)) // mirar amunt per si hi ha una igual
        {
          cambiaAmunt();
        } else {
          numCanvis = 0;
        }
      }
    }
  }

  bool igualEsquerra(int row, int col) {
    bool igual = false;

    var c = col - 1;
    while (!igual && c <= 0) {
      if (m_matriu[row][c] == m_matriu[row][col]) {
        igual = true;
      }
      c--;
    }
    return igual;
  }

  bool igualAmunt(int row, int col) {
    bool igual = false;

    var r = row - 1;
    while (!igual && r <= 0) {
      if (m_matriu[r][col] == m_matriu[row][col]) {
        igual = true;
      }
      r--;
    }
    return igual;
  }

  void cambiaEsquerra(int row, int col) {}

  void cambiaAmunt() {}
  // init matriu a " "
  void initMatriuZeros() {
    for (var i = 0; i < MATRIX_SIZE; i++) {
      List<String> row = [];
      for (var j = 0; j < MATRIX_SIZE; j++) {
        row.add("X");
      }
      m_matriu.add(row);
    }
  }

  int getBoxRow(int row) {
    var boxRow = row;

    while (boxRow - 3 > 2) {
      boxRow -= 3;
    }

    return boxRow;
  }

  int getBoxCol(int col) {
    var boxCol = col;

    while (boxCol - 3 > 2) {
      boxCol -= 3;
    }

    return boxCol;
  }

  // -+-+-+-+-+-+-+-+-+ interaccions fora de la classe
  String getPos(int x, int y) {
    return m_matriu[x][y];
  }
}
