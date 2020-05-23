import 'package:animate_do/animate_do.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class CardOpenPage extends StatefulWidget {
  @override
  _CardOpenPageState createState() => _CardOpenPageState();
}

class _CardOpenPageState extends State<CardOpenPage>
    with TickerProviderStateMixin {
  FlareControls _flareController;

  @override
  void initState() {
    super.initState();
    _flareController = FlareControls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Случайная карточка",
          style: TextStyle(fontFamily: "Montserrat"),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Spin(
              animate: true,
              duration: Duration(seconds: 4),
              controller: (controller) {
                controller.addListener(() {
                  if (controller.isCompleted) {
                    _flareController.play("boom");
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                child: GridTile(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color.fromRGBO(63, 63, 63, 1),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: FlutterLogo(
                            size: 150,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.airplanemode_active,
                                    size: 60,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Text(
                                    "Редкая",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        color: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              child: Text(
                                "Бесплатная поездка в любой город",
                                style: TextStyle(
                                    fontFamily: "Montserrat", fontSize: 26),
                                maxLines: 3,
                              ),
                              padding: EdgeInsets.only(left: 10, right: 10),
                            ),
                            Padding(
                              child: Text(
                                "Получи бесплатную поездку в любой говрод страны собрав нужное количество карточек",
                                style: TextStyle(fontFamily: "Montserrat"),
                                maxLines: 7,
                              ),
                              padding: EdgeInsets.only(left: 10, right: 10),
                            ),
                            Padding(
                              child: Text(""),
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              spins: 150,
            ),
            SizedBox.expand(
              child: FlareActor(
                "assets/flare/conf_red.flr",
                controller: _flareController,
              ),
            ),
            Positioned(
              bottom: 40,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 45,
                child: Material(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white,
                  elevation: 1.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40.0),
                    onTap: () {
                      Navigator.of(context).pop();
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
            )
          ],
        ),
      ),
    );
  }
}
