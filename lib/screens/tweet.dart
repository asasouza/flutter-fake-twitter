// flutter
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/bounce-icon.dart';
import '../widgets/scaffold-container.dart';
import '../widgets/user-item.dart';
// models
import '../models/tweet.dart';
import '../models/user.dart';
// providers
import '../providers/auth.dart';
import '../providers/tweet.dart';
import '../providers/user.dart';
// screens
import '../screens/profile.dart';
// helpers
import '../helpers/colors.dart';

class TweetScreen extends StatefulWidget {
  static const routeName = '/tweet';
  @override
  _TweetScreenState createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  Uint8List bytes;
  final DateFormat dateFormatter = DateFormat('HH:mm • d MMM yy');
  bool loadingLikes = true;
  final NumberFormat numberFormatter = NumberFormat('##,###');
  static final numberRetweets = Random().nextInt(100);
  List<User> tweetLikes = [];

  @override
  void initState() {
    super.initState();

    new Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final tweet = args['tweet'] as Tweet;
      this.fetchLikes(tweet);
    });
  }

  void fetchLikes(Tweet tweet) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    tweet.fetchLikes(0, 9999, authToken: auth.token).then((likes) {
      setState(() {
        tweetLikes = likes;
        loadingLikes = false;
      });
    });
  }

  void _navigateProfile(User user) {
    Navigator.of(context)
        .pushNamed(ProfileScreen.routeName, arguments: {'user': user});
  }

  void _toggleLike(Tweet tweet, String token) {
    tweet.toggleLike(token);
    final mainContextTweet =
        Provider.of<TweetProvider>(context, listen: false).findById(tweet.id);
    mainContextTweet.toggleLike(token,
        forceToggle: tweet.isLiked, numLikes: tweet.likesCount);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final tweet = args['tweet'] as Tweet;
    if (bytes == null) {
      bytes = base64.decode(tweet.author.pictureThumb);
    }
    return ScaffoldContainer(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(
          color: ColorsHelper.lightBlue,
        ),
        title: Text(
          'Tweet',
          style: Theme.of(context).textTheme.title.copyWith(fontSize: 22),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.memory(bytes),
                          ),
                          radius: 30,
                        ),
                        margin: EdgeInsets.only(right: 15),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              tweet.author.name,
                              style: Theme.of(context).textTheme.display2,
                            ),
                            margin: EdgeInsets.only(bottom: 5),
                          ),
                          Container(
                            child: Text(
                              '@${tweet.author.username}',
                              style: Theme.of(context).textTheme.display3,
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )
                    ],
                  ),
                  onTap: () => this._navigateProfile(tweet.author),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    tweet.content,
                    style: Theme.of(context).textTheme.body2,
                  ),
                  margin: EdgeInsets.only(top: 15),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    dateFormatter.format(tweet.createdAt),
                    style: Theme.of(context)
                        .textTheme
                        .display3
                        .copyWith(letterSpacing: 1),
                  ),
                  margin: EdgeInsets.only(top: 15),
                ),
                Container(
                  child: Divider(),
                  margin: EdgeInsets.symmetric(vertical: 5),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        numberFormatter.format(numberRetweets),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      margin: EdgeInsets.only(right: 5),
                    ),
                    Text(
                      'Retweets',
                      style: Theme.of(context).textTheme.display3,
                    ),
                    Container(
                      child: Text(
                        numberFormatter.format(tweet.likesCount),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      margin: EdgeInsets.only(left: 20, right: 5),
                    ),
                    Text(
                      'Likes',
                      style: Theme.of(context).textTheme.display3,
                    ),
                  ],
                ),
                Container(
                  child: Divider(),
                  margin: EdgeInsets.symmetric(vertical: 5),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.chat_bubble_outline, size: 22),
                    ),
                    Container(
                      child: Icon(Icons.swap_horiz, size: 30),
                    ),
                    Container(
                      child: GestureDetector(
                        child: tweet.isLiked
                            ? BounceIcon(
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                ),
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: ColorsHelper.lightGray.shade600,
                                size: 25,
                              ),
                        onTap: () =>
                            this._toggleLike(tweet, auth.token),
                      ),
                    ),
                    Container(
                      child: Icon(Icons.share, size: 22),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 30, right: 30, top: 40),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Liked by',
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(fontWeight: FontWeight.w600)),
                  color: ColorsHelper.darkGray.withOpacity(0.1),
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.only(bottom: 7.5, left: 30, top: 7.5),
                  width: double.infinity,
                ),
                if (loadingLikes)
                  Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      height: 15,
                      width: 15,
                    ),
                  ),
                for (var user in tweetLikes)
                  ChangeNotifierProvider.value(
                    child: Container(
                      child: UserItem(),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    value: user,
                  ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            margin: EdgeInsets.only(top: 10),
          ),
        ],
      ),
    );
  }
}
