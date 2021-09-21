import 'package:flutter/cupertino.dart';
import 'package:notitia/Providers/ProjectHttpClass.dart';
import 'package:notitia/model_data.dart';
import 'package:dash_chat/dash_chat.dart';

class ProjectProvider with ChangeNotifier {
  String _selectedProjectID = "";

  String _seletedProjectName = "";

  List<User> _selectedProjectUsers = [];

  List<Project> _projects = [];

  List<Ticket> _tickets = [];

  Ticket _ticket = Ticket();

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

  Ticket get ticketDetails {
    return _ticket;
  }

  void setSeletedProject(String id) {
    _selectedProjectID = id;
  }

  Ticket getSelectedTicket(String id) {
    return _tickets.firstWhere((element) => element.id == id);
  }

  ProjectHttp _projectHttp = new ProjectHttp();

  Future<void> createProject(
      Map<String, dynamic> projectDataMap, userID) async {
    try {
      final res = await _projectHttp.createProject(projectDataMap, userID);
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
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getProjectDetails(String projectId) async {
    try {
      final res = await _projectHttp.fetchProjectsDetails(projectId);
      final userList = res["data"]["users"] as List;
      final convertedList = res["data"]["tickets"] as List;
      _seletedProjectName = res["data"]["projectName"];

      if (convertedList.length == 0) {
        return _tickets = [];
      }

      final List<User> userLists = userList
          .map((e) => User(
                id: e["id"],
                email: e["email"],
                role: e["Team"]["role"],
                isAuthenticated: true,
              ))
          .toList();

      _selectedProjectUsers = userLists;
      final List<Ticket> dataList = [];

      convertedList.forEach((element) {
        dataList.add(Ticket(
            id: element["id"],
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

      _tickets = dataList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getTicket(String id) async {
    try {
      final res = await _projectHttp.getTicket(id);
      final resConvertedTicket = res["data"] as Map<String, dynamic>;

      final newTicket = Ticket(
          id: resConvertedTicket["id"],
          ticketTitle: resConvertedTicket["ticketTitle"],
          ticketDesc: resConvertedTicket["ticketDesc"],
          userId: resConvertedTicket["userId"],
          projectId: resConvertedTicket["projectId"],
          submittedDev: resConvertedTicket["submittedDev"],
          assignedDev: resConvertedTicket["assignedDev"],
          ticketPriority: resConvertedTicket["ticketPriority"],
          ticketStatus: resConvertedTicket["ticketStatus"],
          ticketType: resConvertedTicket["ticketType"]);
      _ticket = newTicket;
      print(res);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateTicket(String id, Map<String, dynamic> dataMap) async {
    try {
      await _projectHttp.updateTicket(id, dataMap);
    } catch (e) {
      print(e);
    }
  }

  Future<void> inviteToProject(
      String projectId, Map<String, String> dataMap) async {
    try {
      final res = await _projectHttp.inviteToProject(projectId, dataMap);
      final newUser = res["data"];

      User _newUser = User(
          email: newUser["email"],
          role: newUser["role"],
          id: newUser["id"],
          isAuthenticated: true);

      _selectedProjectUsers.add(_newUser);

      notifyListeners();

      print(res);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> createTicket(
      Map<String, dynamic> dataMap, String userID, String projectID) async {
    try {
      final res = await _projectHttp.createTicket(projectID, userID, dataMap);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
