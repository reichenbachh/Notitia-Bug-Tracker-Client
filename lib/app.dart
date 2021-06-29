import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/AuthProvider.dart';
import './Providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import './Screens/MainAppScreen.dart';
import './Screens/login/SignUp.dart';
import './Screens/SplashScreen.dart';
import './Screens/login/SignIn.dart';
import './Screens/login/EmailVerify.dart';
import './Screens/login/ResetPass.dart';
import './Screens/login/CodeVerify.dart';
import './Screens/CreateProject.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<void> _verify;

  @override
  void initState() {
    super.initState();
    _verify = _verifyUser();
  }

  Future<void> _verifyUser() async {
    return Provider.of<AuthProvider>(context, listen: false).validateUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _verify,
      builder: (context, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          print(dataSnapShot.connectionState);
          return Splash();
        }
        return AfterSplash();
      },
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).getUserData;
    if (user.id == null) {
      return SignUp();
    }
    return MainAppScreen();
  }
}
