import 'dart:async';

import 'package:cocaapp/pages/welcome/CodePage.dart';
import 'package:cocaapp/util/Colors.dart';
import 'package:cocaapp/util/EnterExitRoute.dart';
import 'package:cocaapp/util/FadeRoute.dart';
import 'package:cocaapp/util/ScaleRoute.dart';
import 'package:cocaapp/util/SlideRightRoute.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhonePage extends StatefulWidget {
  String phone = "ds";

  PhonePage({this.phone});

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  bool _checked;
  String currentText = "";
  TextEditingController _phoneController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this._checked = false;
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5),
                  padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
                  child: Text(
                    'Coca-Cola',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontFamily: 'CocaCola',
                        color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Club',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontFamily: 'CocaCola',
                        color: Colors.red),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      PinCodeTextField(
                        length: 11,
                        obsecureText: false,
                        animationType: AnimationType.fade,
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        controller: _phoneController,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          borderRadius: BorderRadius.circular(5),
                          selectedColor: Colors.red,
                          fieldWidth:
                              MediaQuery.of(context).size.width / 11 - 10,
                          activeColor: Colors.white,
                          selectedFillColor: Colors.white,
                        ),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: 26),
                        textInputType: TextInputType.number,
                        autoDisposeControllers: false,
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.red),
                            child: Checkbox(
                              value: this._checked,
                              tristate: false,
                              checkColor: Colors.black,
                              activeColor: Colors.red,
                              onChanged: (bool val) {
                                setState(
                                  () {
                                    this._checked = !this._checked;
                                  },
                                );
                              },
                            ),
                          ),
                          Text(
                            "Продолжая, я принимаю условия\nпользовательского соглашения",
                            style: TextStyle(
                                fontFamily: "Montserrat", color: Colors.white),
                            softWrap: true,
                            maxLines: 2,
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: MediaQuery.of(context).size.height / 15,
                        child: _submitButton(),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }

  Widget _submitButton() {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      elevation: 1.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          Navigator.of(context).pushReplacement(FadeRoute(
              page: CodePage(
            phoneNumberString: _phoneController.text,
          )));
        },
        child: Center(
          child: Text(
            'Продолжить',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
          ),
        ),
      ),
    );
  }
}
