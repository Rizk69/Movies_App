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
    bool click = true;
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
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: double.infinity,
                  height: 260,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      ClipRRect(

                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(60)),
                        child: CachedNetworkImage(

                          alignment: Alignment.topCenter,
                          height:double.infinity,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500/${args.backdropPath}',
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Image.asset('images/play-button-2.png')
                    ],
                  ),
                ),
                Positioned(

                  bottom: 0,
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white70, offset: Offset(1, 4),spreadRadius: 0,blurRadius: 12,)
                        ],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50)),
                        color: Color(0XFF282A28)),
                    width: 270,
                    height: 75,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${args.originalTitle}',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${args.releaseDate}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 10, color: Color(0XFFB5B4B4)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.star,
                                    color: Color(0XFFFFBB3B), size: 15),
                                Text(' ${args.voteAverage}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 130,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500/${args.posterPath}',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )),
                      Flex(
                          direction: Axis.horizontal,
                        children: [Column(
                          children: [
                            Container(

                              width: 231,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(maxLines:10 ,softWrap: true,
                                  overflow: TextOverflow.ellipsis,

                                 '${args.overview}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0XFFCBCBCB)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]), SizedBox(
                        height: 5,
                      ),
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
                            height: 240,
                            width: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, DetailsScreen.routename,
                                        arguments: data?.results![index]);
                                  },
                                  child: Container(
                                    height: 240,
                                    width: 100,
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
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
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                click = !click;
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: 36,
                                                width: 27,
                                                decoration: BoxDecoration(
                                                  color: click
                                                      ? Color(0XFF514F4F)
                                                          .withOpacity(0.5)
                                                      : Color(0XFFF7B539),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:Radius.circular(8) ,
                                                          topLeft: Radius.circular(8),
                                                          bottomRight: Radius.circular(8)),

                                                ),
                                                child: Center(
                                                    child: Icon(
                                                  click
                                                      ? Icons.add
                                                      : Icons.check,
                                                  color: Colors.white,
                                                  size: 15,
                                                )),
                                              ),
                                            )
                                          ],
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
