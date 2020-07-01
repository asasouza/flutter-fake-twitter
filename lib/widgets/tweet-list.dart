// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    print(tweets.length);
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Text('Timeline'),
          );
  }
}
