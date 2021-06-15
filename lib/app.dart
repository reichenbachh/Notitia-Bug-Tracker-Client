import 'package:flutter/material.dart';
import './Providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import './Screens/MainAppScreen.dart';
import './Screens/login/SignUp.dart';
import './Screens/login/SignIn.dart';
import './Screens/login/EmailVerify.dart';
import './Screens/login/ResetPass.dart';
import './Screens/login/CodeVerify.dart';
import './Screens/CreateProject.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).getUserData;
    if (user.id == null) {
      return SignUp();
    }
    return MainAppScreen();
  }
}
