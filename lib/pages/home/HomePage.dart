import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cocaapp/pages/cards/CardsPage.dart';
import 'package:cocaapp/pages/music/MusicPage.dart';
import 'package:cocaapp/pages/profile/ProfilePage.dart';
import 'package:cocaapp/pages/qr/QrScanPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Widget _currentAppBar;
  int _currentIndex = 0;
  PageController _pageController;
  CarouselController buttonCarouselController = CarouselController();
  int _currentCard = 0;
  TabController _musicTabController;

  final List<BottomNavyBarItem> _bottomItems = [
    BottomNavyBarItem(
        title: Text(
          'Главная',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        icon: Icon(Icons.home),
        activeColor: Colors.white,
        inactiveColor: Colors.red.shade900),
    BottomNavyBarItem(
        title: Text(
          'Музыка',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        icon: Icon(Icons.music_note),
        activeColor: Colors.white,
        inactiveColor: Colors.red.shade900),
    BottomNavyBarItem(
        title: Text(
          'Карточки',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        icon: Icon(Icons.card_membership),
        activeColor: Colors.white,
        inactiveColor: Colors.red.shade900),
    BottomNavyBarItem(
        title: Text(
          'Профиль',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        icon: Icon(Icons.account_circle),
        activeColor: Colors.white,
        inactiveColor: Colors.red.shade900),
  ];

  final Widget _titleWidget = Container(
    margin: EdgeInsets.only(left: 10, top: 10),
    child: RichText(
      text: TextSpan(
        text: 'Coca-Cola ',
        style: TextStyle(
            fontSize: 40.0, fontFamily: 'CocaCola', color: Colors.white),
        children: [
          TextSpan(
            text: 'Club',
            style: TextStyle(
                fontSize: 40.0, fontFamily: 'CocaCola', color: Colors.red),
          ),
        ],
      ),
    ),
  );

  Widget _homeAppBar() => AppBar(
        title: _titleWidget,
        elevation: 0.0,
        actions: <Widget>[
          Tooltip(
            child: IconButton(
              icon: Icon(FontAwesomeIcons.qrcode, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrScanPage(),
                  ),
                );
              },
            ),
            message: "Сканировать QR-метку",
          )
        ],
      );
  var _items = [
    SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(63, 63, 63, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              child: Column(
                children: <Widget>[
                  Text(
                    'НОВЫХ',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  Text(
                    '458',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0),
                  ),
                  Text(
                    'ОТСКАНИРОВАНО',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 8.0),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              padding: EdgeInsets.only(
                left: 10,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                child: Text(
                  'Сканируй QR метки на этикетке Coca-Cola и получай за них Coca-бонусы',
                  maxLines: 4,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 16.0),
                ),
                padding: EdgeInsets.only(right: 5),
              ),
            )
          ],
        ),
      ),
    ),
    SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(63, 63, 63, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              child: Column(
                children: <Widget>[
                  Text(
                    'БОНУСОВ',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  Text(
                    '206',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0),
                  )
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              padding: EdgeInsets.only(
                left: 10,
              ),
            ),
            Icon(FontAwesomeIcons.coins),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                child: Text(
                  'Бонусы можно потратить на коллекционные карточки и музыку',
                  maxLines: 4,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 16.0),
                ),
                padding: EdgeInsets.only(right: 5),
              ),
            )
          ],
        ),
      ),
    ),
    SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(63, 63, 63, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              child: Column(
                children: <Widget>[
                  Text(
                    'ПРИЗОВ',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  Text(
                    '3',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0),
                  ),
                  Text(
                    'ПОЛУЧЕНО',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              padding: EdgeInsets.only(
                left: 10,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                child: Text(
                  'Когда соберешь нужное количество карточек определенного типа, сможешь получить соответствующий приз',
                  maxLines: 4,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 16.0),
                ),
                padding: EdgeInsets.only(right: 5),
              ),
            )
          ],
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _musicTabController = TabController(length: 2, vsync: this);
    _currentAppBar = _homeAppBar();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentAppBar,
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        backgroundColor: Color.fromRGBO(25, 25, 25, 1),
        onItemSelected: (index) {
          setState(() {
            switch (index) {
              case 0:
                _currentAppBar = _homeAppBar();
                break;
              case 1:
                _currentAppBar = _musicAppBar();
                break;
              case 2:
                _currentAppBar = _cardsAppBar();
                break;
              case 3:
                _currentAppBar = _profileAppBar();
                break;
            }
            _currentIndex = index;
          });
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
          _homePage(context),
          _musicPage(),
          _cardsPage(),
          _profilePage(),
        ],
      ),
    );
  }

  Widget _profileAppBar() => AppBar(
        title: Text(
          "Кайрат С.",
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Tooltip(
            child: IconButton(
              icon: Icon(Icons.edit),
              color: Colors.white.withOpacity(0.5),
              onPressed: () {},
            ),
            message: 'Выйти',
          )
        ],
      );

  Widget _cardsAppBar() => AppBar(
        title: Text(
          "Коллекция Coca-карточек",
          style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        ),
      );

  Widget _musicAppBar() => AppBar(
        elevation: 0.0,
        title: TabBar(
          indicatorColor: Colors.red,
          indicatorPadding: EdgeInsets.only(left: 15, right: 15),
          tabs: <Widget>[
            Padding(
              child: Text(
                "Мои песни",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.only(top: 20, bottom: 10),
            ),
            Padding(
              child: Text(
                "Доступные",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.only(top: 20, bottom: 10),
            )
          ],
          controller: _musicTabController,
        ),
        actions: <Widget>[
          Tooltip(
            child: IconButton(
              icon: Icon(Icons.library_music),
              onPressed: () {},
            ),
            message: "Плеер",
          )
        ],
      );

  Widget _cardsPage() => CardsPage();

  Widget _musicPage() => MusicPage(
        tabController: _musicTabController,
      );

  Widget _profilePage() => ProfilePage();

  Widget _homePage(c) => Container(
        width: MediaQuery.of(c).size.width,
        height: MediaQuery.of(c).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 0,
              bottom: 150,
              child: Image.asset(
                "assets/images/aa.png",
                alignment: Alignment.bottomRight,
                height: 370,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/images/line-hd.png",
                  width: MediaQuery.of(c).size.width,
                  height: 55,
                  fit: BoxFit.fill,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(left: 25, top: 80),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '206',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 80.0),
                        ),
                        Text(
                          'БОНУСОВ',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: MediaQuery.of(c).size.width,
                          child: CarouselSlider(
                            items: _items,
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              autoPlay: true,
                              height: 150,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentCard = index;
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _items.map((url) {
                            int index = _items.indexOf(url);
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentCard == index
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white.withOpacity(0.1),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
