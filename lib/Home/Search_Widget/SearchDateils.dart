import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movise/ResponsData/respon_header.dart';

import '../Home_Widget/Deatials_Screen.dart';

class SearchDateils extends StatelessWidget {
  List<Results> results;
  SearchDateils(this.results);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, DetailsScreen.routename,
                  arguments: results[index]);
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
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500/${results[index].backdropPath}',
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
                                '${results[index].title}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(' ${results[index].releaseDate}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0XFF707070),
                                  )),
                              Text(' ${results[index].originalLanguage}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0XFF707070),
                                  ))
                            ],
                          ),
                        )
                      ]),
                )),
          );
        },
        itemCount: (results.length),
        separatorBuilder: (_, index) {
          return Container(
            color: Color(0XFF514F4F),
            width: double.infinity,
            height: 2,
          );
        },
      ),
    );
  }
}
