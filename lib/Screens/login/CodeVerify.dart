import 'package:flutter/material.dart';
import '../../utils.dart';

class CodeVerify extends StatefulWidget {
  @override
  _CodeVerifyState createState() => _CodeVerifyState();
}

class _CodeVerifyState extends State<CodeVerify> {
  final TextEditingController _codeTextController = TextEditingController();

  final GlobalKey<FormFieldState> _codeFormKey = GlobalKey<FormFieldState>();

  bool _canSubmitForm = false;

  bool _isFormValid() {
    return ((_codeFormKey.currentState.isValid));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _codeTextController.dispose();
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
                  "Enter 4 digit code recieved in email",
                  style:
                      TextStyle(fontSize: 15, color: convertToHex("#06512C")),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                key: _codeFormKey,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                  Icons.vpn_key_outlined,
                  color: convertToHex("#06512C"),
                )),
                onChanged: (value) {
                  setState(() {
                    _codeFormKey.currentState.validate();
                  });
                  _canSubmitForm = _isFormValid();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "please enter the code";
                  }

                  if (value.length < 3 || value.length > 3) {
                    return "code entered should be 4 digits";
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
