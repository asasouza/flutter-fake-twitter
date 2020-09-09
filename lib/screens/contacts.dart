// flutter
import 'package:flutter/material.dart';
// widgets
import '../widgets/scaffold-container.dart';
// models
import '../models/user.dart';
// constants
import '../helpers/colors.dart';

class ContactsScreen extends StatelessWidget {
  static const routeName = '/contacts';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final User user = args['user'];
    final int initalTab = args['initialTab'] == 'following' ? 0 : 1;
    user.fetchContacts(type: args['initialTab']);
    return DefaultTabController(
      child: ScaffoldContainer(
        appBar: AppBar(
          bottom: TabBar(
            labelStyle: TextStyle(
              fontSize: 15,
              color: ColorsHelper.white,
              fontWeight: FontWeight.w600,
            ),
            tabs: <Widget>[
              Tab(text: 'Following'),
              Tab(text: 'Followers'),
            ],
          ),
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Column(
            children: <Widget>[
              Text(
                user.name,
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                '@${user.username}',
                style: Theme.of(context).textTheme.display3,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Text('Seguindo'),
            Text('Seguidores'),
          ],
        ),
      ),
      initialIndex: initalTab,
      length: 2,
    );
  }
}
