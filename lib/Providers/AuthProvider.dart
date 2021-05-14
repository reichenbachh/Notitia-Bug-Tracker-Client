import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as request;
import './httpAuthClass.dart';
import '../model_data.dart';

class AuthProvider with ChangeNotifier {
  Map<String, User> _authData = {};

  HttpAuthClass _httpAuthClass = new HttpAuthClass();

  Future<void> registerUser(Map<String, String> userDataMap) async {
    try {
      final respone = await _httpAuthClass.register(userDataMap);
      print("e  $respone");
      // _authData["authData"] = User(
      //   email: convertedResponse["data"]["email"],
      //   id: convertedResponse["data"]["id"],
      //   profileImageUrl: convertedResponse["data"]["profileImage"],
      //   username: convertedResponse["data"]["username"],
      //   isAuthenticated: true,
      // );

      // final secureStorage = new FlutterSecureStorage();
      // secureStorage.write(key: "athorisation_token", value: authHeader);
    } catch (e) {
      throw e;
    }
  }

  Future<void> loginUser(Map<String, String> userDataMap) async {
    try {
      final respone = await _httpAuthClass.login(userDataMap);
      print("e  $respone");
      // _authData["authData"] = User(
      //   email: convertedResponse["data"]["email"],
      //   id: convertedResponse["data"]["id"],
      //   profileImageUrl: convertedResponse["data"]["profileImage"],
      //   username: convertedResponse["data"]["username"],
      //   isAuthenticated: true,
      // );

      // final secureStorage = new FlutterSecureStorage();
      // secureStorage.write(key: "athorisation_token", value: authHeader);
    } catch (e) {
      throw e;
    }
  }
}
