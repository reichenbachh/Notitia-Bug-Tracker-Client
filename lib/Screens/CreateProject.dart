import 'package:flutter/material.dart';
import 'package:notitia/Providers/AuthProvider.dart';
import 'package:notitia/Screens/MainAppScreen.dart';
import 'package:provider/provider.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:tasty_toast/tasty_toast.dart';

import '../utils.dart';

enum _ProjectStageValues { PreAlpha, Alpha, Beta, Release, Support }

extension parseProjectStateEnums on _ProjectStageValues {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class CreateProject extends StatefulWidget {
  static const routeName = "/createProject";
  const CreateProject({Key? key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  _ProjectStageValues _option = _ProjectStageValues.PreAlpha;

  Widget stageRadioBtn(String title, _ProjectStageValues enumValue) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
            fontSize: 15,
          )),
      leading: Radio(
        groupValue: _option,
        onChanged: (_ProjectStageValues? value) {
          setState(() {
            _option = value!;
          });
        },
        value: enumValue,
      ),
    );
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> projectDataMap = {
    "projectName": "",
    "projectDesc": "",
    "projectStage": ""
  };

  void _submitCreateProject(String userID) {
    try {
      bool isValid = _formKey.currentState!.validate();
      print(isValid);
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();

      print(projectDataMap);

      Provider.of<ProjectProvider>(context, listen: false)
          .createProject(projectDataMap, userID);

      showToast(context, "New project created!",
          textStyle: TextStyle(color: Colors.white),
          background: BoxDecoration(color: Colors.green),
          alignment: Alignment.bottomCenter,
          duration: Duration(seconds: 4));
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (ctx) => MainAppScreen(),
      ))
          .then((value) {
        setState(() async {
          final userID = Provider.of<AuthProvider>(context).getUserData.id;
          await Provider.of<ProjectProvider>(context).getProjects(userID!);
        });
      });
    } catch (e) {
      showToast(context, "An Error occured, please try again",
          textStyle: TextStyle(color: Colors.white),
          background: BoxDecoration(color: Colors.green),
          alignment: Alignment.bottomCenter,
          duration: Duration(seconds: 4));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Create New Project"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(labelText: "Project Name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter a project name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          projectDataMap['projectName'] = value!;
                        },
                      ),
                      TextFormField(
                        maxLines: 5,
                        maxLength: 200,
                        decoration: InputDecoration(
                          labelText: "Project Description",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' please enter  a project description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          projectDataMap["projectDesc"] = value!;
                          projectDataMap['projectStage'] =
                              _option.toShortString();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select a project stage",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: convertToHex("#06512C")),
                        ),
                      ),
                      stageRadioBtn("Pre-Alpha", _ProjectStageValues.PreAlpha),
                      stageRadioBtn("Alpha", _ProjectStageValues.Alpha),
                      stageRadioBtn("Beta", _ProjectStageValues.Beta),
                      stageRadioBtn("Release", _ProjectStageValues.Release),
                      stageRadioBtn("Support", _ProjectStageValues.Support),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            String userID = Provider.of<AuthProvider>(context,
                                    listen: false)
                                .getUserData
                                .id!;
                            _submitCreateProject(userID);
                          },
                          child: Text("Create Project"),
                          style: ElevatedButton.styleFrom(
                            primary: primCol,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
