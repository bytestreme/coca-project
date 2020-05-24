import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cocaapp/authservice.dart';
import 'package:cocaapp/models/CardModel.dart';
import 'package:cocaapp/models/SongModel.dart';
import 'package:cocaapp/pages/home/HomePage.dart';
import 'package:cocaapp/pages/welcome/NamingPage.dart';
import 'package:cocaapp/pages/welcome/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends Model {
  StreamController evenStream = new StreamController.broadcast();

  String backEndUrl = "http://192.168.1.5:8080/";
  Widget currentPage;
  String uid;
  String token;
  String phone;
  String name;
  bool authLoading = false;
  Uint8List bottle;
  int score = 0;
  List<CardModel> userCards = [];
  List<SongModel> userSongs = [];

  void setAuthLoading() {
    authLoading = true;
    notifyListeners();
  }

  void setAuthLoaded() {
    authLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    Response res = await http.post(backEndUrl + "me", headers: getAuthHeader());
    var jsonResponse = convert.jsonDecode(utf8.decode(res.bodyBytes));
    this.uid = jsonResponse['uuid'];
    this.name = jsonResponse['name'].toString();
    this.phone = jsonResponse['phone'];
    this.score = jsonResponse['score'];
    this.userCards = List<CardModel>.from(jsonResponse['gotCards']);
    this.userSongs = List<SongModel>.from(jsonResponse['gotSongs']);
    Response imgBottle =
        await http.get(backEndUrl + "getNamedBottle", headers: getAuthHeader());
    this.bottle = imgBottle.bodyBytes;

    evenStream.sink.add("NAMED");
    notifyListeners();
  }

  Map<String, String> getAuthHeader() {
    return {"Authorization": "Bearer " + this.token};
  }

  void setName(String name) {
    this.name = name;
    http
        .post(backEndUrl + "setName?name=" + name, headers: getAuthHeader())
        .then((r) async {
      await fetchUserData();
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

  signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      this.uid = null;
      this.token = null;
      this.name = null;
      this.phone = null;
      evenStream.sink.add("LOGOUT");
    });
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
