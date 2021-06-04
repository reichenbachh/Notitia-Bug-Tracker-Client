import 'package:flutter/material.dart';
import '../../utils.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordTextController2 =
      TextEditingController();

  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey2 =
      GlobalKey<FormFieldState>();

  bool _canSubitForm = false;
  bool _textIsHidden = false;

  bool _isFormValid() {
    return _passwordFormKey.currentState!.isValid &&
        _passwordFormKey2.currentState!.isValid;
  }

  void _obscureText() {
    setState(() {
      _textIsHidden = !_textIsHidden;
    });
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
                  "Password Reset",
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
                  "Enter new password",
                  style:
                      TextStyle(fontSize: 15, color: convertToHex("#06512C")),
                ),
              ),
              TextFormField(
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
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirm password",
                  style:
                      TextStyle(fontSize: 15, color: convertToHex("#06512C")),
                ),
              ),
              TextFormField(
                key: _passwordFormKey2,
                obscureText: _textIsHidden,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
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
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reset Password",
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
            ],
          ),
        ),
      ),
    ));
  }
}
