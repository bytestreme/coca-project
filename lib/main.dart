import 'package:cocaapp/authservice.dart';
import 'package:cocaapp/scoped/MainModel.dart';
import 'package:cocaapp/util/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
final String backEndUrl = "http://192.168.1.6:8080/";

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  MainModel model = MainModel();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(25, 25, 25, 1)));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      child: ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            backgroundColor: BACKGROUND_COLOR,
            scaffoldBackgroundColor: BACKGROUND_COLOR,
            appBarTheme: AppBarTheme(color: BACKGROUND_COLOR),
          ),
          home: ScopedModelDescendant<MainModel>(
            builder: (_, __, m) {
              return m.handleAuth();
            },
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
