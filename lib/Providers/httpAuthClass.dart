import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as requests;
import './httpException.dart';

class HttpAuthClass {
  static const headers = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  Future<dynamic> register(Map<String, String> data) async {
    try {
      final datas = jsonEncode(data);
      final Uri url = Uri.parse("http://192.168.0.111:5000/auth/register");
      final response = await requests.post(url, headers: headers, body: datas);
      final responseValue = _handleAuthReponses(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> login(Map<String, String> data) async {
    try {
      final datas = jsonEncode(data);
      print(datas);
      final Uri url = Uri.parse("http://192.168.0.111:5000/auth/login");
      final response = await requests.post(url, headers: headers, body: datas);
      final responseValue = _handleAuthReponses(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      throw e;
    }
  }

  dynamic _handleAuthReponses(requests.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
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