import 'package:flutter/material.dart';
import 'package:twitter/model/tweets.dart';
import 'package:twitter/service/twitter_service.dart';

class ListaTweetsPage extends StatefulWidget {
  static String tag = 'lista-tweets-page';
  ListaTweetsPage({Key key}) : super(key: key);

  @override
  _ListaTweetsPageState createState() => _ListaTweetsPageState();
}

class _ListaTweetsPageState extends State<ListaTweetsPage> {
  List<Tweets> tweets = new List<Tweets>();
  List<Tweets> tweets_filter = new List<Tweets>();
  Future<List<Tweets>> future_tweets;
  int count = 0;
  bool loading = true;

  @override
  void initState() {
    // loadingText = -1;
    inicializar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tweets"),
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Search',
                  ),
                  onChanged: (name) {
                    setState(() {
                      tweets_filter = tweets
                          .where((n) => (n.text
                                  .toLowerCase()
                                  .contains(name.toLowerCase()) ||
                              n.created_at
                                  .toLowerCase()
                                  .contains(name.toLowerCase())))
                          .toList();
                      count = tweets_filter.length;
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 20.0),
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return _listItens(index);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  _listItens(index) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    'assets/trump.jpg',
                    width: 50,
                    height: 50,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Donald J. Trump",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "@realDonaldTrump",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                      child: tweets_filter[index].text != null
                          ? Text(
                              tweets_filter[index].text,
                              style: TextStyle(fontSize: 25),
                            )
                          : Text(
                              tweets_filter[index].id_str,
                              style: TextStyle(fontSize: 25),
                            ))
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "RETWEETS",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(tweets[index].retweet_count.toString())
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "FAVORITES",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Text(tweets_filter[index].favorite_count.toString())
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    tweets_filter[index].created_at,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ));
  }

  inicializar() {
    print("Entrou no inicializar");
    future_tweets = TwitterService().getTweets();
    future_tweets.then((value) {
      if (value != null) {
        setState(() {
          tweets = value;
          tweets_filter = tweets;
          count = tweets.length;
          loading = false;
          print("Entrou no future_tweets");
        });
      } else {
        print("Erro");
        showAlertDialogErro(context);
      }
    });
  }

  showAlertDialogErro(BuildContext context) {
    AlertDialog alert;
    Widget okButton = FlatButton(
      child: Text("Tentar Novamente!"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          loading = true;
        });
        inicializar();
      },
    );
    Widget sair = FlatButton(
      child: Text("Tentar Novamente!"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    alert = AlertDialog(
      elevation: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text("Tivemos um problema!"),
      actions: [okButton, sair],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
