import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movise/Api_Manager/ApiManager.dart';

import '../../ResponsData/category.dart';
import '../../ResponsData/respon_header.dart';
import '../Home_Widget/Deatials_Screen.dart';
import 'CataegrDateils.dart';

class BrowserDateails extends StatelessWidget {
  static const String routename='BDea';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Genres;
    int id=(args.id)!;
    return Container(
      decoration: BoxDecoration(

          image: DecorationImage(image:AssetImage('images/bg_category.jpg'),fit: BoxFit.fitHeight,opacity: 2)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            elevation: 1,
            backgroundColor: Color(0XFF121312),
            centerTitle: true,
            title: Text('${args.name}',style: TextStyle(fontSize: 25,color: Colors.white)),
          ),
        ),

        body: Column(
          children: [
            FutureBuilder<ResponHeader>(
                future: ApiManager.getResponsCategoryDateails('$id'),
                builder: (buildContext, snapShot) {
                  if (snapShot.hasError) {
                    return Center(child: Text(snapShot.error.toString()));
                  } else if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var data = snapShot.data;
                  if (data?.success == 'false') {
                    return Center(child: Text('${data?.status_message}'));
                  }
                  return CataegrDateils((snapShot.data?.results)!);

                    ;
                }),
          ],
        ),
      ),
    );
  }
}
