import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/AuthProvider.dart';
import '../../utils.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/signup";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _usernameFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();

  //form state form vars
  bool _canSubmitForm = false;
  bool _textIsHidden = true;

  bool _isEmailFieldValid = false;
  bool _isuserNameFieldValid = false;
  //validate form in realtime
  bool _isFormValid() {
    return ((_emailFormKey.currentState.isValid &&
        _usernameFormKey.currentState.isValid &&
        _passwordFormKey.currentState.isValid));
  }

  void _isEmailValid(GlobalKey<FormFieldState<dynamic>> formKey) {
    if (formKey.currentState.isValid) {
      setState(() {
        _isEmailFieldValid = true;
      });
    }
    if (!formKey.currentState.isValid) {
      setState(() {
        _isEmailFieldValid = false;
      });
    }
  }

  void _isUserNameValid(GlobalKey<FormFieldState<dynamic>> formKey) {
    if (formKey.currentState.isValid) {
      setState(() {
        _isuserNameFieldValid = true;
      });
    }
    if (!formKey.currentState.isValid) {
      setState(() {
        _isuserNameFieldValid = false;
      });
    }
  }

  //change hidden state of password field
  void _obscureText() {
    setState(() {
      _textIsHidden = !_textIsHidden;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(_isEmailFieldValid.toString());
    final loginFunc = Provider.of<AuthProvider>(context);
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
                    "Sign Up",
                    style:
                        TextStyle(fontSize: 30, color: convertToHex("#06512C")),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 15, color: convertToHex("#06512C")),
                    ),
                  ),
                  TextFormField(
                    controller: _emailTextController,
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
                        _emailFormKey.currentState.validate();
                        _canSubmitForm = _isFormValid();
                      });
                    },
                    validator: (value) {
                      if (value.length < 2) {
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
                      "Username",
                      style: TextStyle(
                          fontSize: 15, color: convertToHex("#06512C")),
                    ),
                  ),
                  TextFormField(
                    controller: _usernameTextController,
                    key: _usernameFormKey,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffix: _isuserNameFieldValid == false
                          ? Icon(
                              Icons.error,
                              color: Colors.red,
                            )
                          : Icon(Icons.check),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      _isUserNameValid(_usernameFormKey);
                      setState(() {
                        _usernameFormKey.currentState.validate();
                        _canSubmitForm = _isFormValid();
                      });
                    },
                    validator: (value) {
                      if (value.length < 2) {
                        return "please enter a username";
                      }

                      final validCharacters = new RegExp(r'^[a-zA-Z0-9_]+$');

                      if (!validCharacters.hasMatch(value)) {
                        return "username cannot have special characters";
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
                      style: TextStyle(
                          fontSize: 15, color: convertToHex("#06512C")),
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
                    onChanged: (value) {
                      setState(() {
                        _passwordFormKey.currentState.validate();
                        _canSubmitForm = _isFormValid();
                      });
                    },
                    validator: (value) {
                      if (value.length < 2) {
                        return "please enter a password";
                      }
                      return null;
                    },
                  )
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool value) {},
                    ),
                    Expanded(
                        child: Text(
                      "By creating an account, you agree to ourTerm & Conditions",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: _canSubmitForm
                        ? () async {
                            try {
                              Map<String, String> loginMap = {
                                "email": _emailTextController.text,
                                "username": _usernameTextController.text,
                                "password": _passwordTextController.text,
                              };

                              await loginFunc.loginRequest(loginMap);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign Up",
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
                  height: 20,
                ),
                Text("Already have an account? Sign in"),
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
