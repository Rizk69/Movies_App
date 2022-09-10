import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Api_Manager/ApiManager.dart';
import '../../ResponsData/respon_header.dart';
import '../Home_Widget/Deatials_Screen.dart';

class SearchWidget extends StatefulWidget {
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF121312),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        centerTitle: true,
        title: InkWell(
            onTap: () {
              showSearch(context: context, delegate: ClickSearch());
            },
            child: Text(
              'Search',
              style: TextStyle(fontSize: 25, color: Colors.white),
            )),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: ClickSearch());
                },
                icon: Icon(
                  Icons.search,
                  size: 25,
                )),
          )
        ],
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('images/Group 22.png'))
        ],
      ) ,
    );
  }
}

class ClickSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            showResults(context);
          },
          icon: Icon(
            Icons.search,
            size: 25,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.clear,
          size: 25,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<ResponHeader>(
        future: ApiManager.getResponsSearch(query),
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
            child: ListView.separated(
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, DetailsScreen.routename,arguments:data?.results![index]);
                  },
                  child: Container(
                      color: Colors.black,
                    width: double.infinity,
                      height: 120,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Container(
                        width: 140,
                        height: 120,
                        child:
                        CachedNetworkImage(
                          imageUrl:
                          'https://image.tmdb.org/t/p/w500/${data?.results![index].backdropPath}',
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),


                  ),
                  Container(
                      width: 220,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                      '${data?.results![index].title}',
                      style: TextStyle(
                      fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(
                      height: 5,
                      ),

                      Text(' ${data?.results![index].releaseDate}',
                      style: TextStyle(
                      fontSize: 13,
                      color: Color(0XFF707070),
                      )),Text(' ${data?.results![index].originalLanguage}',
                      style: TextStyle(
                      fontSize: 13,
                      color: Color(0XFF707070),
                      ))


                      ],
                        ),
                  )
                  ]),
                    )),
                ); },
              itemCount: (data?.results?.length)!,
              separatorBuilder: (_, index) {
                return Container(

                  color: Color(0XFF514F4F),
                  width: double.infinity,
                  height: 2,
                );
              },
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Color(0XFF121312),
    );

    ;
  }
}
