import 'package:flutter/cupertino.dart';
import 'package:notitia/Providers/ProjectHttpClass.dart';
import 'package:notitia/model_data.dart';

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects {
    return [..._projects];
  }

  ProjectHttp _projectHttp = new ProjectHttp();

  Future<void> createProject(
      Map<String, dynamic> projectDataMap, userID) async {
    try {
      final res = await _projectHttp.createProject(projectDataMap, userID);
      print(res);
    } catch (e) {
      throw e;
    }
  }

  Future<void> getProjects(String userID) async {
    try {
      print("ruuuun");
      final res = await _projectHttp.fetchProjects(userID);
      final convertedList = res["data"] as List;

      if (convertedList.length == 0) {
        _projects = [];
        return;
      }

      final List<Project> dataList = [];

      convertedList.forEach((item) {
        dataList.add(Project(
            projectName: item["projectName"],
            projectDescription: item["projectDesc"],
            projectStage: item["projectStage"],
            role: item["Team"]["role"]));
      });

      _projects = dataList;
      print(_projects.length);
      notifyListeners();
    } catch (e) {}
  }
}
