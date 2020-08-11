// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/main-drawer.dart';
import '../widgets/rounded-button.dart';
import '../widgets/scaffold-container.dart';
import '../widgets/tweet-list.dart';
// screens
import './new-tweet.dart';
// providers
import '../providers/user.dart';
import '../providers/tweet.dart';
// helpers
import '../helpers/colors.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _tabRoutes;

  int _selectedTab = 0;
  int _offset = 0;
  final _limit = 10;
  bool _moreResults = true;
  bool _requesting = false;

  @override
  initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).populateDataFromStorage();

    _fetchTweets();

    _tabRoutes = [
      // TweetList(
      //   onScroll: fetchTweets,
      //   moreResults: _moreResults,
      //   noContent: EmptyList(() {
      //     _onTabChange(1);
      //   }),
      // ),
      Text('Search'),
    ];
  }

  Future<Null> _fetchTweets() {
    if (!_requesting && _moreResults) {
      setState(() {
        _requesting = true;
      });
      return Provider.of<TweetProvider>(context, listen: false)
          .fetchAndSet(offset: _offset, limit: _limit)
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

  Future<void> _refreshTweets() {
    setState(() {
      _moreResults = true;
      _offset = 0;
    });
    return _fetchTweets();
  }

  void _onTabChange(index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void _openNewTweet(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewTweetScreen(),
        fullscreenDialog: true,
      ),
    );
    if (result) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Tweet created!'),
            duration: Duration(seconds: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorsHelper.lightBlue,
        ),
        centerTitle: false,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.title.copyWith(fontSize: 22),
        ),
      ),
      body: Container(
        color: ColorsHelper.darkBlue,
        child: TweetList(
          onScroll: _fetchTweets,
          moreResults: _moreResults,
          noContent: EmptyList(() {
            _onTabChange(1);
          }),
          onRefresh: _refreshTweets,
        ),
        height: double.infinity,
        width: double.infinity,
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: ColorsHelper.darkBlue,
          currentIndex: this._selectedTab,
          elevation: 10,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              title: Text(''),
            ),
          ],
          onTap: this._onTabChange,
          selectedItemColor: ColorsHelper.lightBlue,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: ColorsHelper.darkGray,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ColorsHelper.darkGray,
              width: 0.5,
            ),
          ),
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () => this._openNewTweet(context),
          );
        },
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  final Function _navigate;

  EmptyList(this._navigate);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Twitter!',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 20),
            Text(
              'This is the best place to see what\'s happening in your world. Find some people and topics to follow now.',
              style: Theme.of(context).textTheme.display1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            SizedBox(
              child: RoundedButton(label: 'Let\'s go', onPress: _navigate),
              width: 100,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50),
      ),
    );
  }
}
