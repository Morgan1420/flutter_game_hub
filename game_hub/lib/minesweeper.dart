import 'package:flutter/material.dart';

class Minesweeper extends StatefulWidget {
  @override
  MinesweeperState createState() => MinesweeperState();
}

class MinesweeperState extends State<Minesweeper> {
  final numOfHorizontalTiles = 12;
  final numOvVerticalTiles = 20;

  bool gameStarted = false;
  List<List<String>> matrix = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Minesweeper")),
        body: InteractiveViewer(
          child: Column(
            children: <Widget>[
              const Expanded(
                child: Divider(color: Colors.transparent),
              ),
              rowBuild(),
              rowBuild(),
              rowBuild(),
              rowBuild(),
              rowBuild(), //5
              rowBuild(),
              rowBuild(),
              rowBuild(),
              rowBuild(),
              rowBuild(), //10
              rowBuild(),
              rowBuild(),
              rowBuild(),
              rowBuild(),
              rowBuild(), //15
              rowBuild(),
              rowBuild(),
              rowBuild(),
              rowBuild(),
              rowBuild(), //20
              const Expanded(
                child: Divider(color: Colors.transparent),
              ),
            ],
          ),
        ));
  }

  Widget minesButton() {
    return Container(
      width: MediaQuery.of(context).size.width / (numOfHorizontalTiles - 1),
      height: MediaQuery.of(context).size.width / (numOfHorizontalTiles - 1),
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width * 0.002,
          )),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.square(
              MediaQuery.of(context).size.width / (numOfHorizontalTiles - 1)),
        ),
        onPressed: null,
        child: Text(
          "a",
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget rowBuild() {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Colors.transparent),
        ),
        minesButton(),
        minesButton(),
        minesButton(),
        minesButton(),
        minesButton(), //5
        minesButton(),
        minesButton(),
        minesButton(),
        minesButton(),
        minesButton(), // 10
        minesButton(),
        minesButton(), // 12
        const Expanded(
          child: Divider(color: Colors.transparent),
        ),
      ],
    );
  }

  void startGame() {}
}
