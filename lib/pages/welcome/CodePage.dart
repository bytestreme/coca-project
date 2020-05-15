import 'dart:async';

import 'package:cocaapp/pages/home/HomePage.dart';
import 'package:cocaapp/pages/welcome/PhonePage.dart';
import 'package:cocaapp/util/EnterExitRoute.dart';
import 'package:cocaapp/util/FadeRoute.dart';
import 'package:cocaapp/util/ScaleRoute2.dart';
import 'package:cocaapp/util/SlideLeftRoute.dart';
import 'package:cocaapp/util/SlideRightRoute.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodePage extends StatefulWidget {
  final String phoneNumberString;

  const CodePage({this.phoneNumberString});

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  bool checked = false;
  String currentText = "";
  TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6),
                  height: MediaQuery.of(context).size.height / 4,
                  child: FlareActor(
                    "assets/flare/otp.flr",
                    animation: "otp",
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Подтверждение номера телефона",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 17),
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 25),
                  child: RichText(
                    text: TextSpan(
                        text: "Введите код, отправленый на ",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 12),
                        children: [
                          TextSpan(
                            text: "+${widget.phoneNumberString}",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.red,
                                fontSize: 15),
                          )
                        ]),
                  ),
                ),
                PinCodeTextField(
                  length: 6,
                  obsecureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  controller: _codeController,
                  pinTheme: PinTheme(
                      activeColor: Colors.red,
                      selectedColor: Colors.red,
                      selectedFillColor: Colors.white),
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
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: RichText(
                    text: TextSpan(
                        text: "Не получили SMS-код? ",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 15),
                        children: [
                          TextSpan(
                            text: "Отправить повторно",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.red,
                                fontSize: 15),
                          )
                        ]),
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      "Сброcить",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: resetCode,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  child: _submitButton(),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.of(context).pushReplacement(FadeRoute(
            page: PhonePage(
          phone: widget.phoneNumberString,
        )));
        return false;
      },
    );
  }

  void resetCode() {
    setState(() {
      _codeController.text = "";
    });
  }

  Widget _submitButton() {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      elevation: 1.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          Navigator.of(context).pushReplacement(
            FadeRoute(
              page: HomePage(),
            ),
          );
        },
        child: Center(
          child: Text(
            'Подтвердить',
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
