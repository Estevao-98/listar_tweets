import 'package:intl/intl.dart';
import 'package:twitter/model/tweets.dart';
import 'package:twitter_api/twitter_api.dart';
import 'dart:convert';

class TwitterService {
  Future<List<Tweets>> getTweets() async {
    List<Tweets> tweets = new List<Tweets>();

// Creating the twitterApi Object with the secret and public keys
// These keys are generated from the twitter developer page
// Dont share the keys with anyone
    final _twitterOauth = new twitterApi(
        consumerKey: "consumerKey",
        consumerSecret: "consumerSecret",
        token: "token",
        tokenSecret: "tokenSecret");

// Make the request to twitter
    Future twitterRequest = _twitterOauth.getTwitterRequest(
      // Http Method
      "GET",
      // Endpoint you are trying to reach
      "statuses/user_timeline.json",
      // The options for the request
      options: {
        // "user_id": "19025957",
        "screen_name": "@realDonaldTrump",
        "count": "15",
        "trim_user": "true",
        "tweet_mode": "extended", // Used to prevent truncating tweets
      },
    );

// Wait for the future to finish
    try {
      var res = await twitterRequest;

// Print off the response
      // print(res.statusCode);
      // print(res.body);
      final parsed = json.decode(res.body);
      // print(parsed);
      tweets = parsed.map<Tweets>((json) => Tweets.fromJson(json)).toList();

      for (int i = 0; i < tweets.length; i++) {
        tweets[i].created_at = tweets[i].created_at.substring(0, 19);
        // print(tweets[i].created_at);

        // print("Tweet " + i.toString());
        // print(tweets[i].text);
        // print(tweets[i].created_at);
        // print(tweets[i].id);
        // print(tweets[i].favorite_count);
        // print(tweets[i].retweet_count);
        // print(tweets[i].id_str);
        // print("--------------------");
      }
      return tweets;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
