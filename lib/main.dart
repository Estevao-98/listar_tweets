import 'package:flutter/material.dart';
import 'package:twitter/page/home_page.dart';
import 'package:twitter/page/lista_tweets_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    ListaTweetsPage.tag: (context) => ListaTweetsPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweets Trump',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: routes,
    );
  }
}
