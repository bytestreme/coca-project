import 'package:cocaapp/scoped/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NamingPage extends StatefulWidget {
  @override
  _NamingPageState createState() => _NamingPageState();
}

class _NamingPageState extends State<NamingPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (_, __, m) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Создание нового профиля",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите ваше имя',
                  hintStyle: TextStyle(fontFamily: "Montserrat"),
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
                      m.setName(_textEditingController.text);
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
              )
            ],
          ),
        );
      },
    );
  }
}
