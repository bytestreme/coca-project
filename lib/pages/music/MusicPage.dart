import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  final TabController tabController;

  const MusicPage({Key key, this.tabController}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.right,
                  color: Colors.black,
                  child: TabBarView(
                    children: <Widget>[
                      ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: Colors.black,
                          child: ListView(
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                      ),
                      ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: Colors.black,
                          child: ListView(
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              Divider(),
                              _buildIngredientRow(
                                  'Starboy - The Weeknd',
                                  'assets/kiwi.png',
                                  '2',
                                  MediaQuery.of(context).size.width),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                    controller: widget.tabController,
                  ),
                ),
              ),
            )
          ]),
    );
  }

  _buildIngredientRow(
      String title, String imgPath, String quantity, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
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
                    child: Row(
                      children: <Widget>[
//                  Container(
//                    height: 50.0,
//                    width: 50.0,
//                    decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image: AssetImage(imgPath),
//                            fit: BoxFit.contain
//                        )
//                    ),
//                  ),
                        Container(
                          width: 50,
                          height: 50,
                          child: FlutterLogo(
                            colors: Colors.red,
                          ),
                        ),
                        SizedBox(width: 25.0),
                        Text(title,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ) // color: Color(0xFFBBBBBB)),
                            )
                      ],
                    )),
                Text(
                  quantity,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: Color(0xFFBBBBBB)),
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
