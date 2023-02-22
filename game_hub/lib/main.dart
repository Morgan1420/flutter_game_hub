import 'package:flutter/material.dart';

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
      home: MainMenu_sf(),
    );
  }
}

class MainMenu_sf extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu_sf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      body: Column(children: <Widget>[
        Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                buildButton("buttonText", Colors.amber, 1),
                buildButton("Minesweeper", Colors.amber, 1),
              ],
            )),
      ]),
    );
  }

  Widget buildButton(
      String buttonText, Color buttonColor, double buttonHeight) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      width: MediaQuery.of(context).size.width * 0.8,
      color: buttonColor,
      child: TextButton(
        onPressed: null,
        child: Text(buttonText),
      ),
    );
  }
}
