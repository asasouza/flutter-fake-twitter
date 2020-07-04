// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// models
import '../models/tweet.dart';
// providers
import '../providers/auth.dart';
// helpers
import '../helpers/colors.dart';

class TweetItem extends StatelessWidget {
  
  String _getCreatedElapsedTime(tweet) {
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
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final tweet = Provider.of<Tweet>(context);
    return Padding(
      child: Row(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              // child: Image.network(tweet.author.pictureThumb),
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
                      _getCreatedElapsedTime(tweet),
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
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        child: Icon(
                          tweet.isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: tweet.isLiked ? Colors.red : ColorsHelper.lightGray.shade600,
                        ),
                        onTap: () {
                          tweet.toggleLike(auth.token);
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
                      constraints: BoxConstraints(minWidth: 40),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                padding: EdgeInsets.only(right: 80),
                width: MediaQuery.of(context).size.width - 95,
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
