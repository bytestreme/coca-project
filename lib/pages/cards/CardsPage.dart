import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardsPage extends StatefulWidget {
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  var cls = [
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.deepOrange,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            child: _buildRandomButton(
                MediaQuery.of(context).size.width, 2.toString()),
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
                  children: List<Widget>.generate(
                    7,
                    (index) => GridTile(
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
                                colors: MaterialColor(cls[index].value, {
                                  50: cls[index],
                                  100: cls[index],
                                  200: cls[index],
                                  300: cls[index],
                                  400: cls[index],
                                  500: cls[index],
                                  600: cls[index],
                                  700: cls[index],
                                  800: cls[index],
                                  900: cls[index]
                                }),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: cls[index],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.airplanemode_active,
                                        size: 60,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, right: 10),
                                      child: Text(
                                        "Редкая",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 20,
                                            color: cls[index]),
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
                                  child: Text(
                                    "Найдено: $index / 150",
                                    style: TextStyle(
                                        fontFamily: "Montserrat", fontSize: 26),
                                    maxLines: 1,
                                  ),
                                  padding:
                                      EdgeInsets.only(left: 10, bottom: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
          onTap: () {},
        ),
      ),
    );
  }
}
