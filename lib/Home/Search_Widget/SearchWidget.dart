import 'package:flutter/material.dart';
import 'package:movise/Home/Search_Widget/SearchDateils.dart';
import '../../Api_Manager/ApiManager.dart';
import '../../ResponsData/respon_header.dart';

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
            child: const Text(
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
                icon: const Icon(
                  Icons.search,
                  size: 25,
                )),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Image.asset('images/Group 22.png'))],
      ),
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
          icon: const Icon(
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
        icon: const Icon(
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
          return SearchDateils((snapShot.data?.results)!);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: const Color(0XFF121312),
    );
  }
}
