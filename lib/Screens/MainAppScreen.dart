import 'package:flutter/material.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:notitia/Screens/TicketsWorkScreen.dart';
import 'package:notitia/Screens/login/SignIn.dart';
import './CreateProject.dart';
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
  late Future<void> _fetchProjects;

  @override
  void initState() {
    super.initState();
    _fetchProjects = _fetchProjectss();
  }

  Future<void> _fetchProjectss() async {
    String userID =
        Provider.of<AuthProvider>(context, listen: false).getUserData.id!;
    return Provider.of<ProjectProvider>(context, listen: false)
        .getProjects(userID);
  }

  @override
  Widget build(BuildContext context) {
    // print(1);
    return FutureBuilder(
        future: _fetchProjects,
        builder: (BuildContext context, dataSnapshop) {
          if (dataSnapshop.connectionState == ConnectionState.waiting) {
            return SafeArea(
                child: Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                backgroundColor: primCol,
              )),
            ));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Projects"),
              actions: [
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                            SignUp.routeName, (route) => false))
              ],
            ),
            body: Consumer<ProjectProvider>(
              builder: (context, data, child) {
                if (data.projects.length == 0) {
                  return SafeArea(
                      child: Scaffold(
                    body: Column(
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "You currently have no projects, click on the add button to add a project",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(
                          flex: 3,
                        )
                      ],
                    ),
                  ));
                }
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                      itemCount: data.projects.length,
                      itemBuilder: (context, i) {
                        return ProjectCard(
                          projectName: data.projects[i].projectName,
                          projectStage: data.projects[i].projectStage,
                          role: data.projects[i].role,
                          projectId: data.projects[i].projectId,
                        );
                      }),
                );
                ;
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CreateProject.routeName);
              },
              child: Icon(Icons.add),
              backgroundColor: convertToHex("#06512C"),
            ),
          );
        });
  }
}
