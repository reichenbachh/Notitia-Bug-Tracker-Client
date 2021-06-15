import 'package:flutter/material.dart';
import './SignUp.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../Providers/AuthProvider.dart';
import '../../utils.dart';
import 'package:tasty_toast/tasty_toast.dart';

class SignIn extends StatefulWidget {
  static const routName = "/signin";
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _stringIDTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  bool _canSubmitForm = false;
  bool _textIsHidden = true;
  bool _isLoading = false;

  //validate form in realtime
  bool _isFormValid() {
    return _emailFormKey.currentState!.isValid &&
        _passwordFormKey.currentState!.isValid;
  }

  //change hidden state of password field
  void _obscureText() {
    setState(() {
      _textIsHidden = !_textIsHidden;
    });
  }

  bool _isEmailFieldValid = false;

  void _isEmailValid(GlobalKey<FormFieldState<dynamic>> formKey) {
    if (formKey.currentState!.isValid) {
      setState(() {
        _isEmailFieldValid = true;
      });
    }
    if (!formKey.currentState!.isValid) {
      setState(() {
        _isEmailFieldValid = false;
      });
    }
  }

  void _submitLogin(Map<String, String> data, BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<AuthProvider>(context, listen: false).loginUser(data);
      print(data);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
      final dataMap = e.toString().split("::")[1];
      final error = jsonDecode(dataMap) as Map<dynamic, dynamic>;

      if (error.containsKey("errors")) {
        setState(() {
          _isLoading = false;
        });
        return showToast(context, error["errors"][0],
            textStyle: TextStyle(color: Colors.white),
            background: BoxDecoration(color: Colors.red),
            alignment: Alignment.topCenter,
            duration: Duration(seconds: 3));
      }

      showToast(context, error["msg"],
          textStyle: TextStyle(color: Colors.white),
          background: BoxDecoration(color: Colors.red),
          alignment: Alignment.topCenter,
          duration: Duration(seconds: 3));

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _stringIDTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign In",
                    style:
                        TextStyle(fontSize: 30, color: convertToHex("#06512C")),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style:
                        TextStyle(fontSize: 15, color: convertToHex("#06512C")),
                  ),
                ),
                TextFormField(
                  controller: _stringIDTextController,
                  key: _emailFormKey,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffix: _isEmailFieldValid == false
                        ? Icon(
                            Icons.error,
                            color: Colors.red,
                          )
                        : Icon(Icons.check),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    _isEmailValid(_emailFormKey);
                    setState(() {
                      _emailFormKey.currentState!.validate();
                      _canSubmitForm = _isFormValid();
                    });
                  },
                  validator: (value) {
                    if (value!.length < 2) {
                      return "please enter a username";
                    }
                    final emailRegex = new RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                      caseSensitive: false,
                    );
                    bool emailIsValid = emailRegex.hasMatch(value);
                    if (!emailIsValid) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style:
                        TextStyle(fontSize: 15, color: convertToHex("#06512C")),
                  ),
                ),
                TextFormField(
                  controller: _passwordTextController,
                  key: _passwordFormKey,
                  obscureText: _textIsHidden,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffix: IconButton(
                      onPressed: _obscureText,
                      icon: _textIsHidden
                          ? Icon(Icons.visibility_off_outlined,
                              color: Theme.of(context).primaryColor)
                          : Icon(Icons.visibility_outlined,
                              color: Theme.of(context).primaryColor),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password field cannot be blank";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _passwordFormKey.currentState!.validate();
                      _canSubmitForm = _isFormValid();
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    Expanded(
                        child: Text(
                      "Keep me signed in",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: _canSubmitForm
                              ? () {
                                  Map<String, String> data = {
                                    "stringID": _stringIDTextController.text,
                                    "password": _passwordTextController.text,
                                  };

                                  _submitLogin(data, context);
                                }
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.login,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    child: Text("Don't have an account ? Sign Up"),
                    onTap: () => Navigator.of(context).pop()),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Text("Forgot password?"),
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
