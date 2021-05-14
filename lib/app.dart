import 'package:flutter/material.dart';
import './Screens/login/SignUp.dart';
import './Screens/login/SignIn.dart';
import './Screens/login/EmailVerify.dart';
import './Screens/login/ResetPass.dart';
import './Screens/login/CodeVerify.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
