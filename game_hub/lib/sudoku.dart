import 'package:flutter/material.dart';

class Sudoku extends StatefulWidget {
  @override
  SudokuState createState() => SudokuState();
}

class SudokuState extends State<Sudoku> {
  // variables sudoku globals
  SudokuBlueprint sudokuSolucio = SudokuBlueprint(true);
  SudokuBlueprint sudokuJugador = SudokuBlueprint(false);
  // build function
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

// -------------------------------------------------------------------------------------------------------------- classe sudoku, on passa tota la màgia
class SudokuBlueprint {
  List<List<String>> m_matriu = [[]];
  List<String> m_boxIndicator = [];

  // constructor de la matriu
  SudokuBlueprint(bool solucio) {
    // omplir els boxs de la matriu amb numeros random de l'1 al 9 (sense repetir)

    // ordenar les files tenint en compte les columnes, d'esquerra a dreta si n'hi ha algun repetit o que no cumpleix condicions el cambiem per unn de la box que si les cumpleixi
  }

  // -+-+-+-+-+-+-+-+-+ funcions del build
  // omple les boxes de la matriu amb numeros random de l'1 al 9 (sense repetir)
  void fillBoxes() {}

  // ordenar les files de la matriu tenint en compte les columnes i la mateixa
  void sortMatrix() {}

  // -+-+-+-+-+-+-+-+-+ interaccions fora de la classe
  String getPos(int x, int y) {
    return m_matriu[x][y];
  }
}
