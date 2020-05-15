import 'package:cocaapp/pages/welcome/PhonePage.dart';
import 'package:cocaapp/util/Colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        backgroundColor: BACKGROUND_COLOR,
        scaffoldBackgroundColor: BACKGROUND_COLOR,
      ),
      home: PhonePage(),
    );
  }
}
