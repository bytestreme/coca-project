import 'dart:async';

import 'package:cocaapp/authservice.dart';
import 'package:cocaapp/pages/home/HomePage.dart';
import 'package:cocaapp/pages/welcome/NamingPage.dart';
import 'package:cocaapp/pages/welcome/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MainModel extends Model {
  StreamController evenStream = new StreamController.broadcast();

  String backEndUrl = "http://192.168.1.5:8080/";
  Widget currentPage;
  String uid;
  String token;
  String phone;
  String name;
  bool authLoading = false;
  bool initFinished = false;
  int score = 0;

  void setAuthLoading() {
    authLoading = true;
    notifyListeners();
  }

  void setAuthLoaded() {
    authLoading = false;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    http.post(
      backEndUrl + "setName?name=" + name,
      headers: {"Authorization": "Bearer " + this.token},
    ).then((r) {
      evenStream.sink.add("NAMED");
      notifyListeners();
    });
  }

  handleAuth() {
    return StreamBuilder(
      stream: evenStream.stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data) {
            case "AUTH":
              print("HERE");
              currentPage = NamingPage();
              break;
            case "NAMED":
              print("HERE");
              currentPage = HomePage();
              break;
            case "LOGOUT":
              print("LOGOUT:HERE");
              currentPage = WelcomePage();
              break;
          }
        } else {
          currentPage = WelcomePage();
        }
        return currentPage;
      },
    );
  }

  signOut()  {
    evenStream.sink.add("LOGOUT");
    print("ds");
//    FirebaseAuth.instance.signOut().then((value) {
//      this.uid = null;
//      this.token = null;
//      this.name = null;
//      this.phone = null;
//    });
  }

  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds).then((value) {
      if (value.user != null) {
        this.uid = value.user.uid;
        value.user.getIdToken().then((value) {
          this.token = value.token;
          print(">>${this.token}<<");
          evenStream.sink.add("AUTH");
        });
      }
    });
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}
