import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  final ScrollController scrollController;

  const ModalFit({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              leading: FlutterLogo(
                colors: Colors.red,
              ),
              title: RichText(
                text: TextSpan(
                  text: 'Песня: ',
                  style: TextStyle(fontFamily: "Montserrat"),
                  children: [
                    TextSpan(
                      text: 'The Weeknd - Starboy',
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
                      text: ' 5 бонусов',
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
                onTap: () {},
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
