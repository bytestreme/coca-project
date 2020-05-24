import 'package:animate_do/animate_do.dart';
import 'package:cocaapp/main.dart';
import 'package:cocaapp/models/CardModel.dart';
import 'package:cocaapp/scoped/MainModel.dart';
import 'package:cocaapp/util/Colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class CardOpenPage extends StatefulWidget {
  final CardModel card;
  MainModel model;

  CardOpenPage({Key key, this.card, this.model}) : super(key: key);

  @override
  _CardOpenPageState createState() => _CardOpenPageState();
}

class _CardOpenPageState extends State<CardOpenPage>
    with TickerProviderStateMixin {
  FlareControls _flareController;
  bool visible = false;
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
                    setState(() {
                      visible = true;
                    });
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
                                      color: HexColor.fromHex(
                                          widget.card.rarity.hexColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    backEndUrl +
                                        "public/getFile?fileId=" +
                                        widget.card.imageId.toString(),
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Text(
                                    widget.card.rarity.title,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 20,
                                      color: HexColor.fromHex(
                                          widget.card.rarity.hexColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              child: Text(
                                widget.card.title,
                                style: TextStyle(
                                    fontFamily: "Montserrat", fontSize: 26),
                                maxLines: 3,
                              ),
                              padding: EdgeInsets.only(left: 10, right: 10),
                            ),
                            Padding(
                              child: Text(
                                widget.card.description,
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
            visible ? Positioned(
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
                      widget.model.fetchUserData().then((value) {
                        Navigator.of(context).pop();
                      });
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
            ) : Container()
          ],
        ),
      ),
    );
  }
}
