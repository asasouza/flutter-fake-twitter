// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/scaffold-container.dart';
// providers
import '../providers/tweet.dart';
// helpers
import '../helpers/colors.dart';

class TweetScreen extends StatefulWidget {
  static const routeName = '/tweet';
  @override
  _TweetScreenState createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final tweet = Provider.of<TweetProvider>(context).findById(args['id']);
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
      body: Center(
        child: Text(args['id']),
      ),
    );
  }
}
