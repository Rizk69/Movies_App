import 'package:flutter/material.dart';

import '../../ResponsData/category.dart';
import 'BrowserDateails.dart';

class SelectCataegry extends StatelessWidget {
  late List<Genres> genres;
  late int index;
  SelectCataegry({required this.genres, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, BrowserDateails.routename,
            arguments: genres[index]);
      },
      child: Container(
        margin: EdgeInsets.all(13),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(0, 1))],
            color: Colors.black38,
            borderRadius: BorderRadius.circular(15)),
        width: 200,
        height: 150,
        child: Center(
            child: Text(
          '${genres[index].name}',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
