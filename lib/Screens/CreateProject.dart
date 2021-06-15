import 'package:flutter/material.dart';
import '../utils.dart';

enum _ProjectStageValues { PreAlpha, Alpha, Beta, Release, Support }

class CreateProject extends StatefulWidget {
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Project Name"),
                      ),
                      TextFormField(
                        maxLines: 5,
                        maxLength: 200,
                        decoration: InputDecoration(
                          labelText: "Project Description",
                        ),
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
                      stageRadioBtn("Support", _ProjectStageValues.Support)
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
