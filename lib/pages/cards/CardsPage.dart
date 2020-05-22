import 'package:flutter/material.dart';

class CardsPage extends StatefulWidget {
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
                  childAspectRatio: 2,
                  children: List<Widget>.generate(
                    3,
                    (index) {
                      return GridTile(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Color.fromRGBO(63, 63, 63, 1),
                          child: Center(
                            child: Text('tile $index'),
                          ),
                        ),
                      );
                    },
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
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: screenWidth,
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: screenWidth * 0.8,
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Открыть случайную карточку",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Color(0xFFBBBBBB)),
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
