// flutter
import 'dart:convert';
import 'package:flutter/material.dart';
// models
import '../models/tweet.dart';
import '../models/user.dart';
// helper
import '../helpers/constants.dart';
import '../helpers/http.dart';

class TweetProvider extends ChangeNotifier {
  final String authToken;
  List<Tweet> _tweets = [];

  TweetProvider({this.authToken});

  List<Tweet> get tweets {
    return [..._tweets];
  }

  Future<bool> createTweet(String content) async {
    return HttpHelper.post(
      '${Constants.baseURL}/tweets',
      body: {'content': content},
      token: authToken,
    ).then((response) {
      if (response.statusCode == 201) {
        final decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final tweet = Tweet(
          author: User(
            id: decodedResponse['tweet']['author']['_id'],
            picture: decodedResponse['tweet']['author']['picture'],
            pictureThumb: decodedResponse['tweet']['author']['pictureThumb'],
            username: decodedResponse['tweet']['author']['username'],
          ),
          content: decodedResponse['tweet']['content'],
          createdAt: decodedResponse['tweet']['createdAt'],
          id: decodedResponse['tweet']['id'],
          likesCount: 0,
          updatedAt: decodedResponse['tweet']['updatedAt'],
        );
        _tweets.insert(0, tweet);
        notifyListeners();
        return true;
      }
      return false;
    });
  }

  Future<void> fetchAndSet({int offset, int limit}) async {
    return HttpHelper.get(
            '${Constants.baseURL}/tweets?offset=$offset&limit=$limit',
            token: authToken)
        .then((response) {
      if (response.statusCode != 200) {
        return;
      }
      final List<Tweet> loadedTweets = [];
      final decodedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      decodedResponse['tweets'].forEach((tweet) {
        loadedTweets.add(
          Tweet(
            author: User(
              id: tweet['author']['_id'],
              picture: tweet['author']['picture'],
              pictureThumb: tweet['author']['pictureThumb'],
              username: tweet['author']['username'],
            ),
            content: tweet['content'],
            createdAt: tweet['createdAt'],
            id: tweet['_id'],
            likesCount: tweet['likesCount'],
            updatedAt: tweet['updatedAt'],
          ),
        );
      });
      _tweets = [..._tweets, ...loadedTweets];
      notifyListeners();
    });
  }
}
