import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movise/ResponsData/respon_header.dart';

import '../../Api_Manager/ApiManager.dart';

class DetailsScreen extends StatefulWidget {
  static const String routename = 'details';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Results;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0XFF1D1E1D),
        title: Text(
          '${args.title}',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
                'https://image.tmdb.org/t/p/w500/${args.backdropPath}'),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${args.originalTitle}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${args.releaseDate}',
                    style: TextStyle(fontSize: 10, color: Color(0XFFB5B4B4)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 130,
                        height: 200,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${args.posterPath}',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 231,
                        child: Column(children: [
                          Text(
                            '${args.overview}',
                            style: TextStyle(
                                fontSize: 13, color: Color(0XFFCBCBCB)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: Color(0XFFFFBB3B), size: 25),
                              Text(' ${args.voteAverage}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ]),
                      )
                    ],
                  )
                ],
              ),
            ),
            FutureBuilder<ResponHeader>(
                future: ApiManager.getResponsSimailar(args.id ?? 610150),
                builder: (buildContext, snapShot) {
                  if (snapShot.hasError) {
                    return Text(' error: ${snapShot.error}',
                        style: TextStyle(color: Colors.white));
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
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
                            'More Like Tihs',
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
                                var datavar = data?.results![index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    height: 220,
                                    width: 100,
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 120,
                                          child: ClipRRect(
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
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Color(0XFFFFBB3B),
                                                size: 15),
                                            Text(
                                                ' ${data?.results![index].voteAverage}',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
        ),
      ),
    );
  }
}
