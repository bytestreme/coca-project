import 'package:cocaapp/pages/home/HomePage.dart';
import 'package:cocaapp/util/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CardOpenPage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(25, 25, 25, 1)));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        backgroundColor: BACKGROUND_COLOR,
        scaffoldBackgroundColor: BACKGROUND_COLOR,
        appBarTheme: AppBarTheme(color: BACKGROUND_COLOR),
      ),
      home: CardOpenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
