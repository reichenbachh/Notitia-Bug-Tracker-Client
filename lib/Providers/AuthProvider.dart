import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import './httpAuthClass.dart';
import '../model_data.dart';

class AuthProvider with ChangeNotifier {
  final secureStorage = new FlutterSecureStorage();
  User _user = new User();

  User get getUserData {
    return _user;
  }

  HttpAuthClass _httpAuthClass = new HttpAuthClass();

  Future<void> registerUser(Map<String, String> userDataMap) async {
    try {
      final respone = await _httpAuthClass.register(userDataMap);
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

  Future<void> validateUser() async {
    try {
      final authToken = await secureStorage.read(key: "athorization_token");
      print(authToken);
      final authTokenString =
          authToken == null || authToken == "undefined" ? "" : authToken;
      final response = await _httpAuthClass.verifyUser(authTokenString);

      final responseValue = jsonDecode(response.body);
      final convertedValue = responseValue as Map<String, dynamic>;

      final User _authenticatedUser = new User(
        email: convertedValue["data"]["email"],
        id: convertedValue["data"]["id"],
        username: convertedValue["data"]["username"],
        profileImageUrl: convertedValue["data"]["profileImage"],
        isAuthenticated: true,
      );

      _user = _authenticatedUser;
      String authHeader = response.headers["authorization"];
      await secureStorage.write(key: "athorization_token", value: authHeader);

      notifyListeners();
    } catch (e) {
      print("e $e");
    }
  }

  Future<void> loginUser(Map<String, String> userDataMap) async {
    try {
      final response = await _httpAuthClass.login(userDataMap);
      final responseValue = jsonDecode(response.body);
      final convertedValue = responseValue as Map<String, dynamic>;

      final User _authenticatedUser = new User(
        email: convertedValue["data"]["email"],
        id: convertedValue["data"]["id"],
        username: convertedValue["data"]["username"],
        profileImageUrl: convertedValue["data"]["profileImage"],
        isAuthenticated: true,
      );

      _user = _authenticatedUser;
      String authHeader = response.headers["authorization"];

      await secureStorage.write(key: "athorization_token", value: authHeader);
    } catch (e) {
      throw e;
    }
  }
}
