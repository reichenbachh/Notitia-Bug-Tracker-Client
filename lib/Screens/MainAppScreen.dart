import 'package:flutter/material.dart';
import 'package:notitia/Screens/login/SignIn.dart';
import 'package:notitia/Screens/login/SignUp.dart';
import 'package:notitia/utils.dart';
import "package:provider/provider.dart";
import '../Providers/AuthProvider.dart';
import '../widgets/ProjectCard.dart';

class MainAppScreen extends StatefulWidget {
  static const routeName = "/mainapp";
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthProvider>(context).getUserData.email;
    print(userData);
    return Scaffold(
      appBar: AppBar(
        title: Text("Projects"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil(SignUp.routeName, (route) => false))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ProjectCard(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: convertToHex("#06512C"),
      ),
    );
  }
}
