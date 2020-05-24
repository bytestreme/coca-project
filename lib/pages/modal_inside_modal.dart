import 'package:cocaapp/main.dart';
import 'package:cocaapp/models/SongModel.dart';
import 'package:cocaapp/scoped/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ModalFit extends StatelessWidget {
  final ScrollController scrollController;
  final SongModel songModel;

  const ModalFit({Key key, this.scrollController, this.songModel})
      : super(key: key);

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
                        songModel.imageId.toString(),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: 'Песня: ',
                      style: TextStyle(fontFamily: "Montserrat"),
                      children: [
                        TextSpan(
                          text: songModel.title,
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
                          text: ' ${songModel.price} бонусов',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    title: Text(
                      'Подтвердить',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onTap: () {
                      model.buySong(songModel.id).then((value) {
                        if (value == 200) {
                          model.fetchUserData().then((value) {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return FlutterLogo(
                                  colors: Colors.blue,
                                );
                              },
                            );
                          });
                        } else {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return FlutterLogo(
                                colors: Colors.red,
                              );
                            },
                          );
                        }
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
