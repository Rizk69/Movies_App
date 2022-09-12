import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../ResponsData/respon_header.dart';
import 'Deatials_Screen.dart';

class HaderDeateils extends StatefulWidget {
 List <Results> results;
  HaderDeateils(this.results);

  @override
  State<HaderDeateils> createState() => _HaderDeateilsState();
}

class _HaderDeateilsState extends State<HaderDeateils> {
  int indexselect = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {

            Navigator.pushNamed(context, DetailsScreen.routename,
                arguments: widget.results[indexselect]);
          },
          child: Stack(
            children: [
              Column(

                children: [
                  Image.network(
                      'https://image.tmdb.org/t/p/w500/${widget.results[indexselect].backdropPath}'),
                  Container(
                    padding: EdgeInsets.only(right: 15,top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [
                        Text(
                          '${widget.results[indexselect].title}',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          '${widget.results[indexselect].releaseDate}',
                          style: TextStyle(color: Colors.white,fontSize: 13),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  )

                ],
              ),
              Positioned(
                bottom: 0,
                left: 20,
                width: 129,
                height: 199,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${widget.results[indexselect].posterPath}',
                ),
              )
            ],
          ),
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
                        onTap: () {
                          indexselect = index;
                          setState(() {});
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(7),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  'https://image.tmdb.org/t/p/w500/${widget.results[index].posterPath}',
                                  placeholder: (context, url) => Center(
                                      child:
                                      CircularProgressIndicator()),
                                  errorWidget:
                                      (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){


                                setState(() {

                                });
                              },
                              child: Container(
                                height: 36,
                                width: 27,
                                decoration: BoxDecoration(
                                  color: Color(0XFF514F4F).withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(bottomLeft:Radius.circular(8) ,
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  // border: Border(
                                  //   bottom: BorderSide(
                                  //     color: Colors.black,
                                  //     width: 3.0,
                                  //   ),
                                  // ),
                                ),
                                child: Center(
                                    child: Icon(
                                    Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount:widget.results.length,
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
}

