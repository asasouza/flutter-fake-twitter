// flutter
import 'package:flutter/material.dart';
// models
import 'package:flutter_fake_twitter/models/tweet.dart';
// helpers
import '../helpers/colors.dart';

class TweetItem extends StatelessWidget {
  final Tweet tweet;

  TweetItem(this.tweet);

  String _getCreatedElapsedTime() {
    final elapsed = DateTime.now().difference(tweet.createdAt);
    if (elapsed.inDays > 0) {
      return '${elapsed.inDays.toString()}d';
    }
    if (elapsed.inHours > 0) {
      return '${elapsed.inHours.toString()}h';
    }
    if (elapsed.inMinutes > 0) {
      return '${elapsed.inMinutes.toString()}m';
    }
    if (elapsed.inSeconds > 30) {
      return '${elapsed.inSeconds.toString()}s';
    }
    return 'now';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Image.network(tweet.author.pictureThumb),
              radius: 25,
            ),
            margin: EdgeInsets.only(right: 15),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Author Name',
                      style: Theme.of(context).textTheme.display2,
                    ),
                    margin: EdgeInsets.only(right: 7),
                  ),
                  Container(
                    child: Text(
                      '@${tweet.author.username}',
                      style: Theme.of(context).textTheme.display3,
                    ),
                    margin: EdgeInsets.only(right: 3),
                  ),
                  Container(
                    child: Text(
                      '•',
                      style: Theme.of(context).textTheme.display3,
                    ),
                    margin: EdgeInsets.only(right: 3),
                  ),
                  Container(
                    child: Text(
                      _getCreatedElapsedTime(),
                      style: Theme.of(context).textTheme.display3,
                    ),
                    margin: EdgeInsets.only(top: 2),
                  ),
                ],
              ),
              Container(
                child: Text(
                  tweet.content,
                  style: Theme.of(context).textTheme.body1,
                ),
                margin: EdgeInsets.only(top: 1, bottom: 5),
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: GestureDetector(
                      child: Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: ColorsHelper.lightGray.shade600,
                      ),
                      onTap: () {
                        print('liked ${tweet.id}');
                      },
                    ),
                    padding: EdgeInsets.only(
                      top: 5,
                      right: 10,
                      bottom: 5,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${tweet.likesCount}',
                      style: Theme.of(context).textTheme.display3.merge(TextStyle(fontSize: 13)),
                    ),
                    margin: EdgeInsets.only(top: 2),
                  )
                ],
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
    );
  }
}
