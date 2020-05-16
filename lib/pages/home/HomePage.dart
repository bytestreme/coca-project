import 'dart:async';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cocaapp/pages/qr/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  final Widget _profilePage = ProfilePage();
  final List<BottomNavyBarItem> _bottomItems = [
    BottomNavyBarItem(
        title: Text(
          'Главная',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        icon: Icon(Icons.home),
        activeColor: Colors.white,
        inactiveColor: Colors.red),
    BottomNavyBarItem(
        title: Text(
          'Музыка',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        icon: Icon(Icons.music_note),
        activeColor: Colors.white,
        inactiveColor: Colors.red),
    BottomNavyBarItem(
        title: Text(
          'Карточки',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        icon: Icon(Icons.card_membership),
        activeColor: Colors.white,
        inactiveColor: Colors.red),
    BottomNavyBarItem(
        title: Text(
          'Профиль',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        icon: Icon(Icons.account_circle),
        activeColor: Colors.white,
        inactiveColor: Colors.red),
  ];
  final Widget _titleWidget = Container(
    margin: EdgeInsets.only(left: 10, top: 10),
    child: RichText(
      text: TextSpan(
        text: 'Coca-Cola ',
        style: TextStyle(
            fontSize: 35.0, fontFamily: 'CocaCola', color: Colors.white),
        children: [
          TextSpan(
              text: 'Club',
              style: TextStyle(
                  fontSize: 35.0, fontFamily: 'CocaCola', color: Colors.red))
        ],
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleWidget,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        backgroundColor: Color.fromRGBO(25, 25, 25, 1),
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: _bottomItems,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'БОНУСОВ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Mostserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                    Text(
                      '206',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Mostserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(25, 25, 25, 1),
            child: FlutterLogo(
              colors: Colors.red,
            ),
          ),
          Container(
            color: Color.fromRGBO(25, 25, 25, 1),
            child: FlutterLogo(
              colors: Colors.green,
            ),
          ),
          _profilePage,
        ],
      ),
    );
  }
}
