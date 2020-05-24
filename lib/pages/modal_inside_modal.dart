import 'package:cocaapp/main.dart';
import 'package:cocaapp/models/SongModel.dart';
import 'package:cocaapp/scoped/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ModalFit extends StatefulWidget {
  final ScrollController scrollController;
  final SongModel songModel;

  const ModalFit({Key key, this.scrollController, this.songModel})
      : super(key: key);

  @override
  _ModalFitState createState() => _ModalFitState();
}

class _ModalFitState extends State<ModalFit> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (_, __, model) {
        return Material(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Получение песни',
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                ListTile(
                  leading: Image.network(
                    backEndUrl +
                        "public/getFile?fileId=" +
                        widget.songModel.imageId.toString(),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: 'Песня: ',
                      style: TextStyle(fontFamily: "Montserrat"),
                      children: [
                        TextSpan(
                          text: widget.songModel.title,
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: 'Будет списано : ',
                      style: TextStyle(fontFamily: "Montserrat"),
                      children: [
                        TextSpan(
                          text: ' ${widget.songModel.price} бонусов',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
//                  child: ListTile(
//                    title: Text(
//                      'Подтвердить',
//                      style: TextStyle(
//                          fontFamily: "Montserrat",
//                          fontWeight: FontWeight.bold,
//                          fontSize: 18),
//                    ),
//
//                  ),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 45,
                    child: Material(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      elevation: 1.0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40.0),
                        onTap: () {
                          setState(() {
                            loading = true;
                          });
                          model.buySong(widget.songModel.id).then((value) {
                            setState(() {
                              loading = false;
                            });
                            if (value == 200) {
                              model.fetchUserData().then((value) {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                    title: "+1 Песня",
                                    description: "Песня добавлена в библиотеку",
                                    buttonText: "Закрыть",
                                  ),
                                );
                              });
                            } else {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                  title: "Ошибка :(",
                                  description: "Не удлалось получить песню",
                                  buttonText: "Закрыть",
                                ),
                              );
                            }
                          });
                        },
                        child: Center(
                          child: loading
                              ? SpinKitThreeBounce(
                                  size: 25,
                                  color: Colors.black,
                                )
                              : Text(
                                  'Продолжить',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
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
