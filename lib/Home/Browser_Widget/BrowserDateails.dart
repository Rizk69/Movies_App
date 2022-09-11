import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movise/Api_Manager/ApiManager.dart';

import '../../ResponsData/category.dart';
import '../../ResponsData/respon_header.dart';
import '../Home_Widget/Deatials_Screen.dart';

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
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, DetailsScreen.routename,arguments:data?.results![index]);
                          },
                          child:Container(

                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(0,1)
                                  )
                                ],
                                color: Colors.black38,
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(50) ,bottomRight:Radius.circular(50) )
                            ),
                            padding: EdgeInsets.only(top: 30,bottom: 30,left: 20,right: 20),
                            margin: EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            height: 150,
                            child: Row(
                              children: [

                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(9),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    'https://image.tmdb.org/t/p/w500/${data?.results![index].posterPath}',
                                    placeholder: (context, url) =>
                                    const Center(
                                        child:
                                        CircularProgressIndicator()),
                                    errorWidget:
                                        (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                                Spacer(),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,

                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            '${data?.results![index].originalTitle}',
                                             style: TextStyle(fontSize: 18,color: Colors.white),
                                          ),
                                        ),

                                    SizedBox(
                                      height: 5,

                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Color(0XFFFFBB3B), size: 25),
                                        Text(' ${data?.results![index].voteAverage}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ]),
                                )


                              ],
                            ),
                          ) ,
                        ); },
                      itemCount: (data?.results?.length)!,

                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
