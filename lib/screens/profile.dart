// flutter
import 'package:flutter/material.dart';
import 'package:flutter_fake_twitter/helpers/colors.dart';
// widgets
import '../widgets/rounded-button.dart';
import '../widgets/scaffold-container.dart';
// models
import '../models/user.dart';

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
      user = await preloadedUser.fetchInfo();
    });
    // new Future.delayed(Duration.zero, () async {
    //   final args =
    //       ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    //   final preloadedUser = args['user'];
    //   user = await preloadedUser.fetchInfo();
    // });
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
                // user.name,
                'User Name',
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                '${user.tweetsCount} Tweets',
                style: Theme.of(context).textTheme.display3,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        body: Column(
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
                      Container(
                        child: RoundedButton(
                          label: 'Follow',
                          onPress: () => user.toggleFollow(''),
                          outline: true,
                        ),
                        width: 120,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(height: 10),
                  Text('User Name',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontSize: 22)),
                  SizedBox(height: 3),
                  Text(
                    '@${preloadedUser.username}',
                    style: Theme.of(context)
                        .textTheme
                        .display3
                        .copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Biografia do usuario',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
              padding: EdgeInsets.only(left: 25, right: 25, top: 20),
            ),
            Divider()
          ],
        ));
  }
}
