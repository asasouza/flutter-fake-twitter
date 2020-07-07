// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import './tweet-item.dart';
// providers
import '../providers/tweet.dart';

class TweetList extends StatefulWidget {
  final bool moreResults;
  final Widget noContent;
  final Function onScroll;

  TweetList({
    @required this.moreResults,
    @required this.noContent,
    @required this.onScroll,
  });

  @override
  _TweetListState createState() => _TweetListState();
}

class _TweetListState extends State<TweetList> {
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController
      ..addListener(() {
        var onScrollThreshold = 0.8 * _scrollController.position.maxScrollExtent;
        if (_scrollController.position.pixels >= onScrollThreshold) {
              widget.onScroll();
              print('In the end - ${widget.moreResults}');
            }
      });
  }

  @override
  Widget build(BuildContext context) {
    final tweets = Provider.of<TweetProvider>(context).tweets;
    if (tweets.length > 0) {
      return ListView.separated(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            child: TweetItem(),
            value: tweets[index],
          );
        },
        itemCount: tweets.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        padding: EdgeInsets.symmetric(vertical: 8),
      );
    } else if (widget.moreResults) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return widget.noContent;
    }
  }
}
