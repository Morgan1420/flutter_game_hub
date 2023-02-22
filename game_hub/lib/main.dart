import 'package:flutter/material.dart';

void main() {
  runApp(MainMenu());
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Menu',
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
    return Scaffold();
  }
}
