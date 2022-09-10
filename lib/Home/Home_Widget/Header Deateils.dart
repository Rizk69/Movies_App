import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Api_Manager/ApiManager.dart';
import '../../ResponsData/respon_header.dart';

class HaderDeateils extends StatelessWidget {
  int indexselect = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
              return Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500/${data?.results![indexselect].backdropPath}',
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
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
                        child:
                        CachedNetworkImage(
                          imageUrl:
                          'https://image.tmdb.org/t/p/w500/${data?.results![indexselect].posterPath}',
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                            // margin: EdgeInsets.only(bottom: 0),
                            height: 145,
                            padding: EdgeInsets.only(top: 8),
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 5, right: 5),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return Container(
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
              print('${snapShot.data?.results![5].posterPath}');
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
                          return Container(
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
    ]);
  }
}
// Container(
//   padding: EdgeInsets.only(top: 15),
//   height: 190,
//   color: Color(0XFF282A28),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       Text(
//         'New Releases',
//         style: TextStyle(
//             fontSize: 16,
//             color: Colors.white,
//             fontWeight: FontWeight.bold),
//       ),
//       Container(
//         // margin: EdgeInsets.only(bottom: 0),
//         height: 135,
//         padding: EdgeInsets.only(top: 8),
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: [
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//           ],
//         ),
//       )
//     ],
//   ),
// ),
// SizedBox(
//   height: 20,
// ),
// Container(
//   padding: EdgeInsets.all(10),
//   height: 250,
//   color: Color(0XFF282A28),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       Text(
//         'Recomended',
//         style: TextStyle(
//             fontSize: 16,
//             color: Colors.white,
//             fontWeight: FontWeight.bold),
//       ),
//       SizedBox(height: 10,),
//       Container(
//         // margin: EdgeInsets.only(bottom: 0),
//         height: 135,
//         padding: EdgeInsets.only(top: 8),
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: [
//             Stack(alignment: Alignment.topLeft,
//               children:[ Image.asset(
//                 'images/Image.jpg',
//                 height: 130,
//                 width: 96,
//               ),
//                 InkWell(
//                     onTap: (){
//
//                       print('click');
//                       setState(() {
//                         click=!click;
//                       });
//                     },
//                     child: Image.asset(click ? 'images/bookmark.png' :'images/bookmark.jpg'))
//             ]),
//             Stack(alignment: Alignment.topLeft,
//                 children:[ Image.asset(
//                   'images/Image.jpg',
//                   height: 130,
//                   width: 96,
//                 ),
//                   Image.asset('images/bookmark.png')
//                 ]),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//             Image.asset(
//               'images/Image.jpg',
//               height: 130,
//               width: 96,
//             ),
//           ],
//         ),
//       )
//     ],
//   ),
// ),
// SizedBox(
//   height: 20,
// ),
