import 'package:flutter/material.dart';
import '../../utils.dart';

class EmailVerify extends StatefulWidget {
  @override
  _EmailVerifyState createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final TextEditingController _emailIDTextController = TextEditingController();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();

  bool _canSubmitForm = false;

  bool _isFormValid() {
    return _emailFormKey.currentState!.isValid;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailIDTextController.dispose();
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
                  "Password Recovery",
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
                  "Enter your email to start recovery",
                  style:
                      TextStyle(fontSize: 15, color: convertToHex("#06512C")),
                ),
              ),
              TextFormField(
                key: _emailFormKey,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  suffix: _emailFormKey.currentState == null ||
                          !_emailFormKey.currentState!.isValid
                      ? SizedBox(
                          height: 40,
                          child: Image.asset(
                            "assets/gif/load.gif",
                            fit: BoxFit.contain,
                          ),
                        )
                      : Icon(Icons.check),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _emailFormKey.currentState!.validate();
                  });
                  _canSubmitForm = _isFormValid();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your email";
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
                height: 20,
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
                        "Continue",
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
