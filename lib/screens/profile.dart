// flutter
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/rounded-button.dart';
import '../widgets/scaffold-container.dart';
import '../widgets/tweet-list.dart';
// models
import '../models/user.dart';
// providers
import '../providers/auth.dart';
import '../providers/tweet.dart';
import '../providers/user.dart';
// screens
import '../screens/settings/name-description.dart';
import '../screens/settings/picture.dart';
// helpers
import '../helpers/colors.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _offset = 0;
  final _limit = 10;
  bool _moreResults = true;
  bool _requesting = false;
  User _user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final preloadedUser = args['user'] as User;
      final auth = Provider.of<AuthProvider>(context, listen: false);
      _fetchTweets(preloadedUser.id);
      preloadedUser.fetchInfo(authToken: auth.token).then((User loadedUser) {
        setState(() {
          _user = loadedUser;
        });
      });
    });
  }

  Future<Null> _fetchTweets(String userId) {
    if (!_requesting && _moreResults) {
      setState(() {
        _requesting = true;
      });
      return Provider.of<TweetProvider>(context, listen: false)
          .fetchAndSet(offset: _offset, limit: _limit, userId: userId)
          .then((moreResults) {
        setState(() {
          _moreResults = moreResults;
          _offset += _limit;
          _requesting = false;
        });
      });
    }
    return null;
  }

  Future<void> _refreshTweets(String userId) {
    setState(() {
      _moreResults = true;
      _offset = 0;
    });
    return _fetchTweets(userId);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final User preloadedUser = args['user'];

    return ScaffoldContainer(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: <Widget>[
            Text(
              preloadedUser.name,
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 2,
            ),
            if (_user != null)
              Text(
                '${_user.tweetsCount} Tweets',
                style: Theme.of(context).textTheme.display3,
              )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      body: Container(
        child: TweetList(
          header: ProfileHeader(user: _user, preloadedUser: preloadedUser),
          moreResults: _moreResults,
          noContent: Text('No content'),
          onRefresh: () => _refreshTweets(preloadedUser.id),
          onScroll: () => _fetchTweets(preloadedUser.id),
        ),
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
    @required this.user,
    @required this.preloadedUser,
  }) : super(key: key);

  final User user;
  final User preloadedUser;

  _renderMemberSince(DateTime createdAt) {
    final DateFormat dateFormatter = DateFormat('MMMM yyyy');
    final date = dateFormatter.format(createdAt);
    return 'Member since $date';
  }

  _navigateToSettingsNameDescription(BuildContext context, User user) {
    Navigator.of(context).pushNamed(
      SettingsNameBioScreen.routeName,
      arguments: {
        'editMode': true,
        'user': user,
      },
    );
  }

  _navigateToSettingsPicture(BuildContext context, User user) {
    Navigator.of(context).pushNamed(
      SettingsPictureScreen.routeName,
      arguments: {
        'editMode': true,
        'user': user,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userLogged = Provider.of<UserProvider>(context, listen: false).user;
    final bytes = base64.decode(preloadedUser.picture);
    return Column(
      children: <Widget>[
        Padding(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.memory(bytes),
                      ),
                      radius: 45,
                    ),
                    onTap: () => _navigateToSettingsPicture(context, user),
                  ),
                  if (user != null && user.id != userLogged.id)
                    Container(
                      child: RoundedButton(
                        label: user.following ? 'Unfollow' : 'Follow',
                        onPress: () => user.toggleFollow(''),
                        outline: !user.following,
                      ),
                      width: 120,
                    ),
                  if (user != null && user.id == userLogged.id)
                    Container(
                      child: RoundedButton(
                        label: 'Edit Profile',
                        onPress: () =>
                            _navigateToSettingsNameDescription(context, user),
                        outline: true,
                      ),
                      width: 120,
                    ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(height: 10),
              Text(preloadedUser.name,
                  style:
                      Theme.of(context).textTheme.title.copyWith(fontSize: 22)),
              SizedBox(height: 3),
              Text(
                '@${preloadedUser.username}',
                style:
                    Theme.of(context).textTheme.display3.copyWith(fontSize: 18),
              ),
              SizedBox(height: 15),
              if (user != null)
                Text(
                  user.bio,
                  style: Theme.of(context).textTheme.body2,
                ),
              SizedBox(
                height: 15,
              ),
              if (user != null)
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      color: ColorsHelper.lightGray.shade600,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      _renderMemberSince(user.createdAt),
                      style: Theme.of(context)
                          .textTheme
                          .display3
                          .copyWith(fontSize: 16),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              SizedBox(
                height: 15,
              ),
              if (user != null)
                Row(
                  children: <Widget>[
                    Text(
                      'following',
                      style: Theme.of(context)
                          .textTheme
                          .display3
                          .copyWith(fontSize: 16),
                    ),
                    SizedBox(width: 5),
                    Text(
                      user.followingCount.toString(),
                      style: Theme.of(context).textTheme.display2,
                    ),
                    SizedBox(width: 20),
                    Text(
                      user.followersCount.toString(),
                      style: Theme.of(context).textTheme.display2,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'followers',
                      style: Theme.of(context)
                          .textTheme
                          .display3
                          .copyWith(fontSize: 16),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              SizedBox(
                height: 5,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 10),
        ),
        Divider(
          color: ColorsHelper.lightBlue,
          height: 30,
          thickness: 2,
        ),
      ],
    );
  }
}
