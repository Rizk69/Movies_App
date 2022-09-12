
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movise/Home/Home_Widget/Deatials_Screen.dart';
import 'package:movise/ResponsData/respon_header.dart';

class CataegrDateils extends StatelessWidget {

  List <Results> results;
  CataegrDateils(this.results);

  @override
  Widget build(BuildContext context) {


    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index) {
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, DetailsScreen.routename,arguments:results[index]);
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
                      'https://image.tmdb.org/t/p/w500/${results[index].posterPath}',
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
                              '${results[index].originalTitle}',
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
                              Text(' ${results[index].voteAverage}',
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
        itemCount: (results.length),

      ),
    );
  }
}
