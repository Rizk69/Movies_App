import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movise/Api_Manager/ApiManager.dart';
import 'package:movise/Home/Home_Widget/Deatials_Screen.dart';
import 'package:movise/ResponsData/respon_header.dart';

import 'Header Deateils.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int indexselect = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<ResponHeader>(
            future: ApiManager.getResponsHeader(),
            builder: (buildContext, snapShot) {
              if (snapShot.hasError) {
                return Text(' error: ${snapShot.error}',
                    style: TextStyle(color: Colors.white));
              } else if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {

                var data = snapShot.data;
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, DetailsScreen.routename,arguments:data?.results![indexselect]);
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.network(
                                  'https://image.tmdb.org/t/p/w500/${data?.results![indexselect].backdropPath}'),
                              Text(
                                '${data?.results![indexselect].title}',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '${data?.results![indexselect].releaseDate}',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            left: 20,
                            width: 129,
                            height: 199,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${data?.results![indexselect].posterPath}',
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, left: 8),
                        height: 190,
                        color: Color(0XFF282A28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'New Releases',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(

                                height: 145,
                                padding: EdgeInsets.only(top: 8),
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 5, right: 5),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {

                                    return InkWell(
                                      onTap: (){
                                        indexselect=index;
                                        setState(() {
                                        });


                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5, right: 5),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(7),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                            'https://image.tmdb.org/t/p/w500/${data?.results![index].posterPath}',
                                            placeholder: (context, url) => Center(
                                                child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: data?.results?.length,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              }
            }),
        FutureBuilder<ResponHeader>(
            future: ApiManager.getResponsTopRated(),
            builder: (buildContext, snapShot) {
              if (snapShot.hasError) {
                return Text(' error: ${snapShot.error}',
                    style: TextStyle(color: Colors.white));
              } else if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                var data = snapShot.data;
                return Container(
                  padding: EdgeInsets.only(top: 15, left: 8),
                  height: 246,
                  color: Color(0XFF282A28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Recomendede',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: 200,
                        width: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap:(){
                                Navigator.pushNamed(context, DetailsScreen.routename,arguments:data?.results![index]);
                              },
                              child: Container(
                                height: 220,
                                width: 100,
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(9),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          'https://image.tmdb.org/t/p/w500/${data?.results![index].posterPath}',
                                          placeholder: (context, url) =>
                                          const Center(
                                              child:
                                              CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Color(0XFFFFBB3B), size: 15),
                                        Text(
                                            ' ${data?.results![index].voteAverage}',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Text(
                                      '${data?.results![index].originalTitle}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      '${data?.results![index].releaseDate}',
                                      style: TextStyle(
                                        fontSize: 7,
                                        color: Color(0XFFB5B4B4),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: data?.results?.length,
                        ),
                      ),
                    ],
                  ),
                );
              }
            })
      ],
    ) ;
  }
}
//FutureBuilder<ResponHeader>(
//         future: ApiManager.getResponsHeader(),
//         builder: (buildContext, snapShot) {
//           if (snapShot.hasError) {
//             return Text(' error: ${snapShot.error}',
//                 style: TextStyle(color: Colors.white));
//           } else if (snapShot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             print('${snapShot.data?.results![5].posterPath}');
//             var data = snapShot.data;
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Image.network(
//                               'https://image.tmdb.org/t/p/w500/${data?.results![indexselect].backdropPath}'),
//                           Text(
//                             '${data?.results![0].title}',
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                             textAlign: TextAlign.right,
//                           ),
//                           Text(
//                             '${data?.results![0].releaseDate}',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.right,
//                           )
//                         ],
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         left: 20,
//                         width: 129,
//                         height: 199,
//                         child: Image.network(
//                           'https://image.tmdb.org/t/p/w500/${data?.results![indexselect].posterPath}',
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 15,left: 8),
//                     height: 190,
//                     color: Color(0XFF282A28),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'New Releases',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                             // margin: EdgeInsets.only(bottom: 0),
//                             height: 145,
//                             padding: EdgeInsets.only(top: 8),
//                             child: ListView.builder(
//                               padding: EdgeInsets.only(
//                                   bottom: 10, left: 5, right: 5),
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (_, index) {
//                                 return Container(
//                                   padding: EdgeInsets.only(left: 5, right: 5),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(7),
//                                     child: CachedNetworkImage(
//                                       imageUrl:
//                                           'https://image.tmdb.org/t/p/w500/${data?.results![index].posterPath}',
//                                       placeholder: (context, url) => Center(
//                                           child: CircularProgressIndicator()),
//                                       errorWidget: (context, url, error) =>
//                                           Icon(Icons.error),
//                                     ),
//                                   ),
//                                 );
//                               },
//                               itemCount: data?.results?.length,
//                             ))
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 15,left: 8),
//                     height: 246,
//                     color: Color(0XFF282A28),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Recomendede',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(top: 10),
//                           height: 200,
//                           width: 100,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (_, index) {
//                               return Container(
//                                 height: 220,
//                                 width: 100,
//                                 padding: EdgeInsets.only(left: 5, right: 5),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       height: 120,
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(9),
//                                         child: CachedNetworkImage(
//                                           imageUrl:
//                                               'https://image.tmdb.org/t/p/w500/${data?.results![index].posterPath}',
//                                           placeholder: (context, url) => const Center(
//                                               child:
//                                                   CircularProgressIndicator()),
//                                           errorWidget: (context, url, error) =>
//                                               const Icon(Icons.error),
//                                         ),
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Icon(Icons.star,
//                                             color: Color(0XFFFFBB3B), size: 15),
//                                         Text(
//                                             ' ${data?.results![index].voteAverage}',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold)),
//                                       ],
//                                     ),
//                                     Text(
//                                       '${data?.results![index].originalTitle}',
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                       textAlign: TextAlign.start,
//                                     ),
//                                     Text(
//                                       '${data?.results![index].releaseDate}',
//                                       style: TextStyle(
//                                         fontSize: 7,
//                                         color: Color(0XFFB5B4B4),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                             itemCount: data?.results?.length,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         })
