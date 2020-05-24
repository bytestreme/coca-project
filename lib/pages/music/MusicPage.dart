import 'package:cocaapp/main.dart';
import 'package:cocaapp/models/SongModel.dart';
import 'package:cocaapp/pages/modal_inside_modal.dart';
import 'package:cocaapp/scoped/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MusicPage extends StatefulWidget {
  final TabController tabController;
  MainModel model;

  MusicPage({Key key, this.tabController, this.model}) : super(key: key);

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
                    _buildMySongsList(),
                    _buildAvailableList()
                  ],
                  controller: widget.tabController,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildMySongsItem(SongModel model, double screenWidth) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          width: screenWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    backEndUrl +
                        "public/getFile?fileId=" +
                        model.imageId.toString(),
                  ),
                ),
              ),
              Expanded(
                child: Text(model.title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ) // color: Color(0xFFBBBBBB)),
                    ),
                flex: 5,
              ),
              SizedBox(width: 25.0),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.cloud_download),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ));
  }

  _buildMyItem(double screenWidth, SongModel songModel) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Material(
        color: Colors.transparent,
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
                        child: ClipRRect(
                          child: Image.network(
                            backEndUrl +
                                "public/getFile?fileId=" +
                                songModel.imageId.toString(),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      SizedBox(width: 25.0),
                      Text(songModel.title,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ) // color: Color(0xFFBBBBBB)),
                          )
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(25, 25, 25, 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.cloud_download),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          onTap: () => showMaterialModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context, scrollController) => ModalFit(
              scrollController: scrollController,
              songModel: songModel,
            ),
          ),
        ),
      ),
    );
  }

  _buildAvailableSongsItem(double screenWidth, SongModel songModel) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Material(
        color: Colors.transparent,
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
                        child: ClipRRect(
                          child: Image.network(
                            backEndUrl +
                                "public/getFile?fileId=" +
                                songModel.imageId.toString(),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      SizedBox(width: 25.0),
                      Text(songModel.title,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ) // color: Color(0xFFBBBBBB)),
                          )
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(25, 25, 25, 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    songModel.price.toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color(0xFFBBBBBB),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () => showMaterialModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context, scrollController) => ModalFit(
              scrollController: scrollController,
              songModel: songModel,
            ),
          ),
        ),
      ),
    );
  }

  _buildMySongsList() {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: Colors.black,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: widget.model.userSongs.length,
          itemBuilder: (_, int index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildMyItem(
                  MediaQuery.of(context).size.width,
                  widget.model.userSongs[index],
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildAvailableList() {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: Colors.black,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: widget.model.allSongs.length,
          itemBuilder: (_, int index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildAvailableSongsItem(MediaQuery.of(context).size.width,
                    widget.model.allSongs[index]),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
