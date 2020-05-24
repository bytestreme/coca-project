import 'package:cocaapp/scoped/MainModel.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';
import 'package:scoped_model/scoped_model.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  bool loading = false;
  String _last = "";

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (_, __, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Сканирование QR метки",
              style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: ClipRRect(
                    child: SizedBox(
                      child: Stack(
                        children: <Widget>[
                          QrCamera(
                            formats: [BarcodeFormats.QR_CODE],
                            qrCodeCallback: (text) {
                              if (text == _last) return;
                              _last = text;
                              setState(() {
                                this.loading = true;
                              });
                              model.validateQr(text).then((value) {
                                setState(() {
                                  this.loading = false;
                                });
                                if (value == 200) {
                                  model.fetchUserData();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                      title: "+1 Бонус",
                                      description:
                                          "Метка успешно активирована!",
                                      buttonText: "Закрыть",
                                    ),
                                  );
                                } else {
                                  _last = "";
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                      title: "Ошибка :(",
                                      description:
                                          "Не удлалось активировать метку, вероятно она уже использована или неверная",
                                      buttonText: "Закрыть",
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                          loading
                              ? SpinKitRipple(
                                  color: Colors.white.withOpacity(0.5),
                                  size: 250,
                                )
                              : Container(),
                          loading
                              ? Center(
                                  child: Text(
                                    "Обработка...",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      width: 250,
                      height: 250,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.only(top: 25),
                ),
                Padding(
                  child: SizedBox(
                    child: FlareActor(
                      "assets/flare/qrscan.flr",
                      animation: 'scan',
                    ),
                    width: 250,
                    height: 250,
                  ),
                  padding: EdgeInsets.only(top: 25),
                ),
                Padding(
                  child: Text(
                    "Наведите камеру на этикетку с QR-меткой",
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  ),
                  padding: EdgeInsets.only(top: 25),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.black,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Montserrat",
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Consts.avatarRadius,
            child: Image.asset("assets/images/cokelogo.png"),
          ),
        ),
        //...bottom card part,
        //...top circlular image part,
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
