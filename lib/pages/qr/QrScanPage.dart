import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  @override
  Widget build(BuildContext context) {
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
                  child: QrCamera(
                    qrCodeCallback: (text) {},
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
  }
}
