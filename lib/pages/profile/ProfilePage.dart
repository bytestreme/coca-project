import 'package:cocaapp/scoped/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (_, __, m) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: RichText(
                  text: TextSpan(
                      text: "Номер телефона: ",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: " ${m.phone}",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
                padding: EdgeInsets.only(top: 55, left: 15),
              ),
              Padding(
                child: RichText(
                  text: TextSpan(
                      text: "Регион: ",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: "${m.location}",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
                padding: EdgeInsets.only(top: 15, left: 15),
              ),
              Padding(
                child: FlatButton(
                    child: Text(
                      "Выйти",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      m.signOut();
                    }),
                padding: EdgeInsets.only(top: 75),
              ),
              Padding(
                child: FlatButton(
                  child: Text(
                    "Удалить учетную запись",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  onPressed: () {},
                ),
                padding: EdgeInsets.only(top: 75),
              )
            ],
          ),
        );
      },
    );
  }
}
