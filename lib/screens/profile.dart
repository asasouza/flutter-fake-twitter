// flutter
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final User user = args['user'];
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
                '44,6k Tweets',
                style: Theme.of(context).textTheme.display3,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        body: Padding(
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
                      outline: true,
                    ),
                    width: 120,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(
                height: 10
              ),
              Text('User Name',
                  style:
                      Theme.of(context).textTheme.title.copyWith(fontSize: 22)),
              SizedBox(
                height: 3
              ),
              Text(
                '@${user.username}',
                style: Theme.of(context).textTheme.display3.copyWith(fontSize: 18),
              ),
              SizedBox(height: 15),
              Text('user.bio', style: Theme.of(context).textTheme.body2,),
              Divider()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.only(left: 25, right: 25, top: 20),
        ));
  }
}
