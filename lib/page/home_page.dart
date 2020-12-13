import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/model/tweets.dart';
import 'package:twitter/page/lista_tweets_page.dart';
import 'package:twitter/service/twitter_service.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
            child: Column(
          children: <Widget>[
            // Image.asset(name),
            // Icon(Icons.)
            FaIcon(
              FontAwesomeIcons.twitter,
              size: 100.0,
              color: Colors.cyan,
            ),
            Container(
              child: Text("Seja bem vindo ao conteúdo irônico de Tweets!"),
            ),
            RaisedButton(
              child: Text(
                "Listar Tweets",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // Future<List<Tweets>> future_tweets = TwitterService().getTweets();
                Navigator.of(context).pushNamed(ListaTweetsPage.tag);
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.cyan,
            )
          ],
        ))
      ],
    ));
  }
}
