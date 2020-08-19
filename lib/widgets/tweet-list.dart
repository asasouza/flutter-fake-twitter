// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import './tweet-item.dart';
// providers
import '../providers/tweet.dart';

class TweetList extends StatefulWidget {
  final Widget header;
  final bool moreResults;
  final Widget noContent;
  final Function onScroll;
  final Function onRefresh;

  TweetList({
    this.header,
    @required this.moreResults,
    @required this.noContent,
    @required this.onScroll,
    @required this.onRefresh,
  });

  @override
  _TweetListState createState() => _TweetListState();
}

class _TweetListState extends State<TweetList> {
  final ScrollController _scrollController = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    _scrollController
      ..addListener(() {
        var onScrollThreshold =
            0.8 * _scrollController.position.maxScrollExtent;
        if (_scrollController.position.pixels >= onScrollThreshold) {
          widget.onScroll();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final tweets = Provider.of<TweetProvider>(context).tweets;
    if (tweets.length > 0) {
      return RefreshIndicator(
        child: ListView.separated(
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                if (widget.header != null && index == 0) widget.header,
                ChangeNotifierProvider.value(
                  child: TweetItem(),
                  value: tweets[index],
                ),
                if (index == tweets.length - 1 && widget.moreResults)
                  Padding(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                      ),
                      height: 15,
                      width: 15,
                    ),
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
              ],
            );
          },
          itemCount: tweets.length,
          separatorBuilder: (context, index) {
            return Divider();
          },
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        key: _refreshIndicatorKey,
        onRefresh: widget.onRefresh,
      );
    } else if (widget.moreResults) {
      return Column(
        children: <Widget>[
          if (widget.header != null) widget.header,
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          if (widget.header != null) widget.header,
          widget.noContent,
        ],
      );
    }
  }
}
