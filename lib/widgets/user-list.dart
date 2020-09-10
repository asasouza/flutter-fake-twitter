// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/user-item.dart';
// providers
import '../providers/auth.dart';
// models
import '../models/user.dart';

class UserList extends StatefulWidget {
  final String type;
  final User user;

  UserList({
    @required this.type,
    @required this.user,
  });

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users;

  @override
  void initState() {
    super.initState();

    final auth = Provider.of<AuthProvider>(context, listen: false);
    widget.user
        .fetchContacts(authToken: auth.token, type: widget.type)
        .then((contacts) {
      setState(() {
        users = contacts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(users);

    if (users == null) {
      return Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
          height: 15,
          width: 15,
        ),
      );
    }

    if (users.length == 0) {
      return Center(child: Text('No users'),);
    }

    return Column(children: <Widget>[
      for (var contact in users)
                  ChangeNotifierProvider.value(
                    child: Container(
                      child: UserItem(),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    value: contact,
                  ),
    ],);
  }
}
