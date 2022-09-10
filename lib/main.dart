import 'package:flutter/material.dart';
import 'package:movise/Home/Home_Screen.dart';
import 'package:movise/Home/Home_Widget/Deatials_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routenamed,
      routes: {
        HomeScreen.routenamed :(_)=> HomeScreen(),
        DetailsScreen.routename:(_)=> DetailsScreen()
      },
    );
  }
}

