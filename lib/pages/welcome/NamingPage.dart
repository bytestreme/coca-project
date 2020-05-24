import 'package:cocaapp/scoped/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class NamingPage extends StatefulWidget {
  @override
  _NamingPageState createState() => _NamingPageState();
}

class _NamingPageState extends State<NamingPage> {
  TextEditingController _textEditingController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (_, __, m) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Создание профиля",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Привет, как тебя зовут?",
                  style: TextStyle(fontFamily: "Montserrat", fontSize: 20),
                ),
                Center(
                  child: Padding(
                    child: TextField(
                      style: TextStyle(fontFamily: "Montserrat", fontSize: 25),
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.red)),
                        hintText: "Cola",
                        hintStyle:
                            TextStyle(fontFamily: "Montserrat", fontSize: 18),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 50, right: 50),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 45,
                  child: Material(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.white,
                    elevation: 1.0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40.0),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          loading = true;
                        });
                        m.setName(_textEditingController.text);
                      },
                      child: Center(
                        child: loading
                            ? SpinKitThreeBounce(
                                size: 25,
                                color: Colors.black,
                              )
                            : Text(
                                'Продолжить',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
