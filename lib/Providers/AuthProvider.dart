import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as request;

class AuthProvider with ChangeNotifier {
  bool _isUserAuthenticated = false;

  Future<void> loginRequest(Map<String, String> userDataMap) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
    final Uri url = Uri.parse("http://192.168.0.111:5000/auth/register");
    final body = jsonEncode(userDataMap);
    final loginResponse = await request.post(url, headers: headers, body: body);

    debugPrint(loginResponse.body);
  }
}
