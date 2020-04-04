// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/scaffold-container.dart';
// providers
import '../providers/auth.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Logout'),
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
          },
        ),
      ),
    );
  }
}
