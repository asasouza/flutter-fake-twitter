// Flutter
import 'package:flutter/material.dart';
// Widgets
import '../widgets/scaffold-container.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('This is home!'),
      ),
    );
  }
}
