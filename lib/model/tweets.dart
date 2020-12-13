import 'package:scoped_model/scoped_model.dart';

class Tweets extends Model {
  String created_at;
  int id;
  String id_str;
  String text;
  int retweet_count;
  int favorite_count;

  Tweets(
      {this.created_at,
      this.id,
      this.id_str,
      this.text,
      this.retweet_count,
      this.favorite_count});

  factory Tweets.fromJson(Map<String, dynamic> json) {
    return Tweets(
      created_at: json['created_at'],
      id: json['id'],
      id_str: json['id_str'],
      text: json["full_text"],
      retweet_count: json['retweet_count'],
      favorite_count: json['favorite_count'],
    );
  }
}
