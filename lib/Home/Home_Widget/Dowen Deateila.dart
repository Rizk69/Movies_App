import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../ResponsData/respon_header.dart';
import 'Deatials_Screen.dart';
class DownDetails extends StatefulWidget {
 List <Results> results;
  DownDetails(this.results);

  @override
  State<DownDetails> createState() => _DownDetailsState();
}

class _DownDetailsState extends State<DownDetails> {
  @override
  Widget build(BuildContext context) {
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
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            height: 200,
            width: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, DetailsScreen.routename,
                        arguments: widget.results[index]);
                  },
                  child: Container(
                    height: 220,
                    width: 100,
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500/${widget.results[index].posterPath}',
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {

                                setState(() {});
                              },
                              child: Container(
                                height: 36,
                                width: 27,
                                decoration: BoxDecoration(
                                  color: Color(0XFF514F4F).withOpacity(0.5),

                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8)),
                                  // border: Border(
                                  //   bottom: BorderSide(
                                  //     color: Colors.black,
                                  //     width: 3.0,
                                  //   ),
                                  // ),
                                ),
                                child: Center(
                                    child: Icon(
                                   Icons.add ,
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
                                color: Color(0XFFFFBB3B), size: 15),
                            Text(' ${widget.results[index].voteAverage}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                          '${widget.results[index].originalTitle}',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          '${widget.results[index].releaseDate}',
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
              itemCount: widget.results.length,
            ),
          ),
        ],
      ),
    );
  }
}
