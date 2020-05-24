import 'package:cocaapp/CardOpenPage.dart';
import 'package:cocaapp/main.dart';
import 'package:cocaapp/scoped/MainModel.dart';
import 'package:cocaapp/util/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardsPage extends StatefulWidget {
  MainModel model;

  CardsPage(this.model);

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            child: _buildRandomButton(
                MediaQuery.of(context).size.width, 5.toString()),
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.black,
                child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                  children: widget.model.userCardDisplay.length > 0
                      ? List<Widget>.generate(
                          widget.model.userCardDisplay.length,
                          (index) => GridTile(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Color.fromRGBO(10, 10, 10, 1),
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, left: 10),
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: HexColor.fromHex(widget
                                                    .model
                                                    .userCardDisplay[index]
                                                    .rarity
                                                    .hexColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Image.network(
                                              backEndUrl +
                                                  "public/getFile?fileId=" +
                                                  widget.model.userCardDisplay[index]
                                                      .imageId
                                                      .toString(),
                                              height: 60,
                                              width: 60,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Text(
                                              widget
                                                  .model
                                                  .userCardDisplay[index]
                                                  .rarity
                                                  .title,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 20,
                                                  color: HexColor.fromHex(widget
                                                      .model
                                                      .userCardDisplay[index]
                                                      .rarity
                                                      .hexColor)),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        child: Text(
                                          widget.model.userCardDisplay[index]
                                              .title,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 26),
                                          maxLines: 3,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                      ),
                                      Padding(
                                        child: Text(
                                          widget.model.userCardDisplay[index]
                                              .description,
                                          style: TextStyle(
                                              fontFamily: "Montserrat"),
                                          maxLines: 7,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                      ),
                                      Padding(
                                        child: Text(
                                          "Найдено: ${widget.model.userCardDisplay[index].quantity} / ${widget.model.userCardDisplay[index].requiredNumber}",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 26),
                                          maxLines: 1,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : [
                          Container(
                            child: Text("No cards"),
                          )
                        ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildRandomButton(double screenWidth, String q) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: screenWidth,
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  "assets/images/cokelogo.png",
                  height: 55,
                  alignment: Alignment.center,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  width: screenWidth * 0.7,
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Открыть случайную карточку",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  child: Text(
                    q,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Color(0xFFBBBBBB),
                    ),
                  ),
                  padding: EdgeInsets.only(right: 5, left: 5),
                )
              ],
            ),
          ),
          onTap: () {
            widget.model.openCard().then((card) {
              showDialog(
                  context: context,
                  builder: (c) {
                    return CardOpenPage(card: card, model: widget.model);
                  });
            });
          },
        ),
      ),
    );
  }
}
