import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as requests;
import './httpException.dart';

class ProjectHttp {
  static const headers = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  static const apiUrl = 'http://172.18.176.1:5000';

  Future<dynamic> createProject(
      Map<String, dynamic> projectDataMap, String userID) async {
    try {
      final datas = jsonEncode(projectDataMap);
      final Uri url = Uri.parse("$apiUrl/project/createProject/$userID");
      final response = await requests.post(url, headers: headers, body: datas);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> fetchProjects(String userID) async {
    try {
      final Uri url = Uri.parse("$apiUrl/project/getProjects/$userID");
      final response = await requests.get(url, headers: headers);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> fetchProjectsDetails(String projectId) async {
    try {
      final Uri url = Uri.parse("$apiUrl/project/getProject/$projectId");
      final response = await requests.get(url, headers: headers);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> createTicket(
      String projectId, String userID, Map<String, dynamic> dataMap) async {
    try {
      final datas = jsonEncode(dataMap);
      final Uri url = Uri.parse(
          "$apiUrl/ticket/createTicket?userId=$userID&projectId=$projectId");
      final response = await requests.post(url, headers: headers, body: datas);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getTicketInfo(
      String projectId, String userID, Map<String, dynamic> dataMap) async {
    try {
      final datas = jsonEncode(dataMap);
      final Uri url = Uri.parse(
          "$apiUrl/ticket/createTicket?userId=$userID&projectId=$projectId");
      final response = await requests.post(url, headers: headers, body: datas);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> inviteToProject(
      String projectId, Map<String, dynamic> dataMap) async {
    try {
      final datas = jsonEncode(dataMap);
      final Uri url =
          Uri.parse("$apiUrl/project/inviteToProject?projectId=$projectId");
      final response = await requests.post(url, headers: headers, body: datas);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getTicket(String id) async {
    try {
      final Uri url = Uri.parse("$apiUrl/ticket/getTicket?id=$id");
      final response = await requests.get(url, headers: headers);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> updateTicket(
      String ticketID, Map<String, dynamic> dataMap) async {
    try {
      final datas = jsonEncode(dataMap);
      final Uri url = Uri.parse("$apiUrl/ticket/updateTicket?id=$ticketID");
      final response = await requests.patch(url, headers: headers, body: datas);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  dynamic _handleResponse(requests.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseValue = jsonDecode(response.body);
        return responseValue;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
