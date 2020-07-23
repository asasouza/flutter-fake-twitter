// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import './rounded-button.dart';
// model
import '../models/user.dart';

class UserItem extends StatelessWidget {
  // final User user;

  // UserItem(this.user);

  void _toggleFollow(User user) {
    print('teste');
    user.toggleFollow();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print('build!!');
    return Padding(
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  // child: Image.network(user.pictureThumb),
                  radius: 23,
                  backgroundColor: Colors.grey,
                ),
                margin: EdgeInsets.only(right: 10),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'User Name',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    '@${user.username}',
                    style: Theme.of(context).textTheme.display3,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Bio do usuário',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(
            child: RoundedButton(
              label: user.following ? 'Following' : 'Follow',
              onPress: () => this._toggleFollow(user),
              outline: !user.following,
              padding: 0,
            ),
            height: 33,
            width: 100,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    );
  }
}
