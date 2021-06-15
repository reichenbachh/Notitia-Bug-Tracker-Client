import 'package:flutter/material.dart';
import 'package:notitia/utils.dart';
import '../widgets/ProjectCard.dart';

class MainAppScreen extends StatefulWidget {
  static const routeName = "/mainapp";
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Projects"),
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
