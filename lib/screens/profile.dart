// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/rounded-button.dart';
import '../widgets/scaffold-container.dart';
import '../widgets/tweet-list.dart';
// models
import '../models/user.dart';
// providers
import '../providers/user.dart';
// helpers
import '../helpers/colors.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final preloadedUser = args['user'];

      preloadedUser.fetchInfo().then((User loadedUser) {
        setState(() {
          user = loadedUser;
        });
      });
    });
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
              // preloaded.name,
              'User Name',
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 2,
            ),
            if (user != null)
              Text(
                '${user.tweetsCount} Tweets',
                style: Theme.of(context).textTheme.display3,
              )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      // body: ProfileHeader(user: user, preloadedUser: preloadedUser));
      body: Container(
        child: TweetList(
          header: ProfileHeader(user: user, preloadedUser: preloadedUser),
          moreResults: false,
          noContent: Text('No content'),
          onRefresh: () {},
          onScroll: () {},
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

  @override
  Widget build(BuildContext context) {
    final userLogged = Provider.of<UserProvider>(context, listen: false).user;
    return Column(
      children: <Widget>[
        Padding(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 45,
                  ),
                  // if(user != null && user.id != userLogged.id)
                  if(user != null)
                  Container(
                    child: RoundedButton(
                      label: user.following ? 'Unfollow' : 'Follow',
                      onPress: () => user.toggleFollow(''),
                      outline: !user.following,
                    ),
                    width: 120,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(height: 10),
              Text('User Name',
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
                      'Member since Aug 2020',
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
