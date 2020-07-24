// flutter
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/bounce-icon.dart';
import '../widgets/scaffold-container.dart';
import '../widgets/user-item.dart';
// Models
import '../models/tweet.dart';
import '../models/user.dart';
// providers
import '../providers/auth.dart';
import '../providers/tweet.dart';
// helpers
import '../helpers/colors.dart';

class TweetScreen extends StatefulWidget {
  static const routeName = '/tweet';
  @override
  _TweetScreenState createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  final DateFormat dateFormatter = DateFormat('HH:mm • d MMM yy');
  bool loadingLikes = true;
  final NumberFormat numberFormatter = NumberFormat('##,###');
  List<User> tweetLikes = [];

  @override
  void initState() {
    super.initState();

    new Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final tweet = Provider.of<TweetProvider>(context, listen: false)
          .findById(args['id']);
      this.fetchLikes(tweet);
    });
  }

  void fetchLikes(Tweet tweet) {
    tweet.fetchLikes(0, 9999).then((likes) {
      setState(() {
        tweetLikes = likes;
        loadingLikes = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final tweet =
        Provider.of<TweetProvider>(context, listen: false).findById(args['id']);

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
                Row(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        // child: Image.network(
                        //   tweet.author.picture,
                        // ),
                        radius: 30,
                      ),
                      margin: EdgeInsets.only(right: 15),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Author Name',
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
                        numberFormatter.format(tweet.likesCount),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      margin: EdgeInsets.only(right: 5),
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
                Container(
                  alignment: Alignment.topLeft,
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
                    onTap: () {
                      tweet.toggleLike(auth.token);
                      setState(() {});
                    },
                  ),
                  padding: EdgeInsets.only(
                    left: 25,
                  ),
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
