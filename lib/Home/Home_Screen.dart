import 'package:flutter/material.dart';
import 'package:movise/Home/Browser_Widget/BrowserWidget.dart';
import 'package:movise/Home/Home_Widget/HomeWidget.dart';
import 'package:movise/Home/Search_Widget/SearchWidget.dart';
import 'package:movise/Home/WatchList_Widget/WatchListWidget.dart';

class HomeScreen extends StatefulWidget {
  static const String routenamed = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectindex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF121312),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0XFF1A1A1A),
          selectedItemColor: Color(0XFFFFBB3B),
          unselectedItemColor: Color(0XFFB5B4B4),
          currentIndex: selectindex,
          onTap: (index) {
            selectindex = index;
            setState(() {});
          },

          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/Home icon.png')),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/search-2.png')),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/Icon material-movie.png')),
                label: 'Browser'),
            BottomNavigationBarItem(
                icon:
                    ImageIcon(AssetImage('images/Icon ionic-md-bookmarks.png')),
                label: 'WatchList')
          ],
        ),
        body: tabs[selectindex],
      ),
    );
  }

  List<Widget> tabs = [
    HomeWidget(),
    SearchWidget(),
    BrowserWidget(),
    WatchListWidget()
  ];
}
