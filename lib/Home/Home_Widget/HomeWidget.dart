import 'package:flutter/material.dart';
import 'package:movise/Api_Manager/ApiManager.dart';
import 'package:movise/Home/Home_Widget/Dowen%20Deateila.dart';
import 'package:movise/ResponsData/respon_header.dart';
import 'Header Deateils.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int indexselect = 0;
  bool click = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<ResponHeader>(
              future: ApiManager.getResponsHeader(),
              builder: (buildContext, snapShot) {
                if (snapShot.hasError) {
                  return Text(' error: ${snapShot.error}',
                      style: TextStyle(color: Colors.white));
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  var data = snapShot.data;
                  return HaderDeateils((data?.results)!);
                }
              }),
          FutureBuilder<ResponHeader>(
              future: ApiManager.getResponsTopRated(),
              builder: (buildContext, snapShot) {
                if (snapShot.hasError) {
                  return Text(' error: ${snapShot.error}',
                      style: TextStyle(color: Colors.white));
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  var data = snapShot.data;

                  return DownDetails((data?.results)!);
                }
              })
        ],
      ),
    );
  }
}
