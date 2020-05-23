import 'package:cocaapp/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  CrossFadeState _fadeState = CrossFadeState.showFirst;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  String currentText = "";
  bool _checked = false;
  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 300),
        crossFadeState: _fadeState,
        firstChild: GestureDetector(
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
                    padding:
                        EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
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
                              data:
                                  ThemeData(unselectedWidgetColor: Colors.red),
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
                                  fontFamily: "Montserrat",
                                  color: Colors.white),
                              softWrap: true,
                              maxLines: 2,
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height: MediaQuery.of(context).size.height / 15,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            elevation: 1.0,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20.0),
                              onTap: () {
                                setState(() {
                                  verifyPhone("+${_phoneController.text}").then((value) {
                                    _fadeState = CrossFadeState.showSecond;
                                  });
                                });
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
                          ),
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
        secondChild: Container(
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
                            text: "+${_phoneController.text}",
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
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    elevation: 1.0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () {
                        AuthService().signInWithOTP(_codeController.text, verificationId);
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
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetCode() {
    setState(() {
      _codeController.text = "";
    });
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
