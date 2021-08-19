import 'package:flutter/material.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:notitia/Screens/TicketsScreen.dart';
import 'package:notitia/Screens/TicketsWorkScreen.dart';
import 'package:provider/provider.dart';
import './Providers/AuthProvider.dart';
import './Screens/MainAppScreen.dart';
import './Screens/login/SignUp.dart';
import './Screens/login/SignIn.dart';
import './Screens/login/EmailVerify.dart';
import './Screens/login/ResetPass.dart';
import './Screens/login/CodeVerify.dart';
import './Screens/CreateProject.dart';
import './utils.dart';
import 'app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => ProjectProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: convertToHex("#06512C"),
        ),
        routes: {
          "/": (ctx) => App(),
          SignUp.routeName: (ctx) => SignUp(),
          SignIn.routName: (ctx) => SignIn(),
          MainAppScreen.routeName: (ctx) => MainAppScreen(),
          CreateProject.routeName: (ctx) => CreateProject(),
          TicketScreen.routeName: (ctx) => TicketScreen(),
          Ticketwork.routeName: (ctx) => Ticketwork()
        },
      ),
    );
  }
}
