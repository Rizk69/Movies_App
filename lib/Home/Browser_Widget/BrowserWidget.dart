import 'package:flutter/material.dart';
import 'package:movise/ResponsData/category.dart';

import '../../Api_Manager/ApiManager.dart';
import 'SelectCataegry.dart';

class BrowserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg_category.jpg'),
              fit: BoxFit.fitHeight,
              opacity: 2)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              elevation: 1,
              backgroundColor: Color(0XFF121312),
              centerTitle: true,
              title: Text(
                'Browse Category',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          body: Container(
              child: FutureBuilder<CategoryData>(
                  future: ApiManager.getResponsCategory(),
                  builder: (buildContext, snapShot) {
                    if (snapShot.hasError) {
                      return Text(' error: ${snapShot.error}',
                          style: TextStyle(color: Colors.white));
                    } else if (snapShot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      var data = snapShot.data;
                      return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 5,
                          children:
                              List.generate((data?.genres?.length)!, (index) {
                            return Center(
                              child: SelectCataegry(
                                genres: (data?.genres)!,
                                index: index,
                              ),
                            );
                          }));
                    }
                  }))),
    );
  }
}
