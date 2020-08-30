// flutter
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import 'bounce-icon.dart';
import 'icon-button.dart' as FT;
// models
import '../models/tweet.dart';
import '../models/user.dart';
// providers
import '../providers/auth.dart';
import '../providers/tweet.dart';
// screens
import '../screens/profile.dart';
import '../screens/tweet.dart';
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

  static final random = new Random();
  final int numberComments = random.nextInt(100);
  final int numberRetweets = random.nextInt(100);

  void _navigateProfile(BuildContext context, User user) {
    if(ModalRoute.of(context).settings.name != ProfileScreen.routeName) {
      Navigator.of(context)
        .pushNamed(ProfileScreen.routeName, arguments: {'user': user});
    }
  }

  void _toggleLike(Tweet tweet, String token, BuildContext context) {
    // tweet.toggleLike(token);
    final mainContextTweet =
        Provider.of<TweetProvider>(context, listen: false).findById(tweet.id);
    print(mainContextTweet == tweet);
    mainContextTweet.toggleLike(token);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final tweet = Provider.of<Tweet>(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: Container(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  // child: Image.network(tweet.author.pictureThumb),
                  radius: 25,
                ),
                margin: EdgeInsets.only(right: 15),
              ),
              onTap: () => this._navigateProfile(context, tweet.author),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Row(
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
                        ],
                      ),
                      onTap: () => this._navigateProfile(context, tweet.author),
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
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 95),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      FT.IconButton(
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          size: 16,
                        ),
                        text: this.numberComments.toString(),
                        onPress: () {},
                      ),
                      FT.IconButton(
                        icon: Icon(
                          Icons.swap_horiz,
                          size: 18,
                        ),
                        text: this.numberRetweets.toString(),
                        onPress: () {},
                      ),
                      FT.IconButton(
                        color: tweet.isLiked
                            ? Colors.red
                            : ColorsHelper.lightGray.shade600,
                        icon: tweet.isLiked
                            ? BounceIcon(
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: ColorsHelper.lightGray.shade600,
                                size: 18,
                              ),
                        onPress: () =>
                            this._toggleLike(tweet, auth.token, context),
                        text: tweet.likesCount.toString(),
                      ),
                      FT.IconButton(
                        icon: Icon(
                          Icons.share,
                          size: 16,
                        ),
                        text: '',
                        onPress: () {},
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(TweetScreen.routeName, arguments: {'tweet': tweet});
      },
    );
  }
}
