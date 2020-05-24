import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cocaapp/authservice.dart';
import 'package:cocaapp/main.dart';
import 'package:cocaapp/models/CardDisplay.dart';
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
import 'package:cocaapp/models/CardDisplay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends Model {
  StreamController evenStream = new StreamController.broadcast();

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
  List<SongModel> allSongs = [];
  List<CardDisplay> userCardDisplay = [];

  void setAuthLoading() {
    authLoading = true;
    notifyListeners();
  }

  void setAuthLoaded() {
    authLoading = false;
    notifyListeners();
  }

  Future<CardModel> openCard() async {
    Response res =
        await http.get(backEndUrl + "getCard", headers: getAuthHeader());
    var jsonResponse = convert.jsonDecode(utf8.decode(res.bodyBytes));
    return CardModel.fromJson(jsonResponse);
  }

  Future<int> buySong(int id) async {
    Response res = await http.post(
        backEndUrl + "buySong?songId=" + id.toString(),
        headers: getAuthHeader());
    return res.statusCode;
  }

  Future<void> fetchUserData() async {
    userCardDisplay = [];
    Response res = await http.post(backEndUrl + "me", headers: getAuthHeader());
    var jsonResponse = convert.jsonDecode(utf8.decode(res.bodyBytes));
    this.uid = jsonResponse['uuid'];
    this.name = jsonResponse['name'].toString();
    this.phone = jsonResponse['phone'];
    this.score = jsonResponse['score'];

    this.userCards = List<Map<String, dynamic>>.from(jsonResponse['gotCards'])
        .map((e) => CardModel.fromJson(e))
        .toList();

    for (CardModel c in this.userCards) {
      var product = this
          .userCardDisplay
          .firstWhere((card) => card.id == c.id, orElse: () => null);
      if (product == null) {
        this.userCardDisplay.add(CardDisplay.name(c.id, c.title, c.description,
            c.requiredNumber, c.rarity, c.imageId, 1));
      } else {
        product.quantity++;
      }
    }

    this.userSongs = List<Map<String, dynamic>>.from(jsonResponse['gotSongs'])
        .map((e) => SongModel.fromJson(e))
        .toList();
    Response imgBottle =
        await http.get(backEndUrl + "getNamedBottle", headers: getAuthHeader());
    this.bottle = imgBottle.bodyBytes;

    Response allSongs = await http.get(backEndUrl + "public/getSongs");
    var allSongsJson = convert.jsonDecode(utf8.decode(allSongs.bodyBytes));
    this.allSongs = List<Map<String, dynamic>>.from(allSongsJson)
        .map((e) => SongModel.fromJson(e))
        .toList();

    for (int i = this.allSongs.length - 1; i >= 0; i--) {
      var existingSong = this.userSongs.firstWhere(
          (song) => song.id == this.allSongs[i].id,
          orElse: () => null);
      if (existingSong != null) {
        this.allSongs.removeAt(i);
      }
    }

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
