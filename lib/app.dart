import 'package:flutter/material.dart';
import './Screens/login/SignUp.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return SignUp();
  }
}
