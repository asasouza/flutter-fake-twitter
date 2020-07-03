// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import './tweet-item.dart';
// providers
import '../providers/tweet.dart';

class TweetList extends StatefulWidget {
  @override
  _TweetListState createState() => _TweetListState();
}

class _TweetListState extends State<TweetList> {
  var _isLoading = true;

  @override
  void initState() {
    super.initState();

    Provider.of<TweetProvider>(
      context,
      listen: false,
    ).fetchAndSet(offset: 0, limit: 10).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tweets = Provider.of<TweetProvider>(context).tweets;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              final tweet = tweets[index];
              return TweetItem(tweet);
            },
            itemCount: tweets.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
            padding: EdgeInsets.symmetric(vertical: 8),
          );
  }
}
