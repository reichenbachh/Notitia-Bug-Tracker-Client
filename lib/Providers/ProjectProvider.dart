import 'package:flutter/cupertino.dart';
import 'package:notitia/Providers/ProjectHttpClass.dart';
import 'package:notitia/model_data.dart';

class ProjectProvider with ChangeNotifier {
  String _selectedProjectID = "";

  String _seletedProjectName = "";

  List<Project> _projects = [];

  List<Ticket> _tickets = [];

  List<Project> get projects {
    return [..._projects];
  }

  List<Ticket> get tickets {
    return [..._tickets];
  }

  String get selectedProjectName {
    return _seletedProjectName;
  }

  String get getSelectedProjectID {
    return _selectedProjectID;
  }

  void setSeletedProject(String id) {
    _selectedProjectID = id;
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
      final res = await _projectHttp.fetchProjects(userID);
      final convertedList = res["data"] as List;

      if (convertedList.length == 0) {
        _projects = [];
        return;
      }

      final List<Project> dataList = [];

      convertedList.forEach((item) {
        dataList.add(Project(
            projectId: item["id"],
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

  Future<dynamic> getProjectDetails(String projectId) async {
    try {
      final res = await _projectHttp.fetchProjectsDetails(projectId);
      print(res);
      final convertedList = res["data"]["tickets"] as List;
      _seletedProjectName = res["data"]["projectName"];
      if (convertedList.length == 0) {
        return _tickets = [];
      }

      final List<Ticket> dataList = [];

      convertedList.forEach((element) {
        dataList.add(Ticket(
            ticketTitle: element["ticketTitle"],
            ticketDesc: element["ticketDesc"],
            userId: element["userId"],
            projectId: element["projectId"],
            submittedDev: element["submittedDev"],
            assignedDev: element["assignedDev"],
            ticketPriority: element["ticketPriority"],
            ticketStatus: element["ticketStatus"],
            ticketType: element["ticketType"]));
      });

      print("aaaaaaaaaaaaaaaaaaaa");

      _tickets = dataList;
      print(_tickets);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> createTicket(
      Map<String, dynamic> dataMap, String userID, String projectID) async {
    try {
      final res = await _projectHttp.createTicket(projectID, userID, dataMap);
      print(res);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
