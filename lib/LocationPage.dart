import 'package:cocaapp/scoped/MainModel.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scoped_model/scoped_model.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  FlareControls _flareController;
  Position _currentPosition;
  String _currentAddress = " ";
  bool located = false;

  @override
  void initState() {
    super.initState();
    _flareController = FlareControls();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (_, __, model) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Регион участника: $_currentAddress",
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    child: Text(
                        "Чтобы завершить регистрацию, нам нужно знать с какого ты города",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "Montserrat", fontSize: 16)),
                    padding: EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 50),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: FlareActor(
                      "assets/flare/locate.flr",
                      controller: _flareController,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 45,
                    child: Material(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      elevation: 1.0,
                      child: !located
                          ? InkWell(
                        borderRadius: BorderRadius.circular(40.0),
                        onTap: () {
                          _flareController.play("record");
                          _getCurrentLocation();
                        },
                        child: Center(
                          child: Text(
                            'Поделиться локацией',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      )
                          : InkWell(
                        borderRadius: BorderRadius.circular(40.0),
                        onTap: () {
                          model.located(_currentAddress);
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
            ),
          ),
        );
      },
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude,
          localeIdentifier: "ru_RU");

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
        located = true;
        _flareController.play("jump");
      });
    } catch (e) {
      print(e);
    }
  }
}
