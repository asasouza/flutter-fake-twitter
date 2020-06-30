// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/main-drawer.dart';
import '../widgets/scaffold-container.dart';
// screens
import './new-tweet.dart';
// providers
import '../providers/user.dart';
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

  @override
  initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).populateDataFromStorage();

    _tabRoutes = [
      Container(
        width: 100,
        height: 100,
        // child: RaisedButton(
        //   child: Text('Logout'),
        //   onPressed: () {
        //     Provider.of<AuthProvider>(context, listen: false).logout();
        //   },
        // ),
      ),
      Text('Search'),
    ];
  }

  void _onTabChange(index) {
    setState(() {
      _selectedTab = index;
    });
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
        child: _tabRoutes[_selectedTab],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NewTweetScreen(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
    );
  }
}
