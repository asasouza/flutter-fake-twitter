// flutter
import 'package:flutter/material.dart';
// widgets
import '../widgets/scaffold-container.dart';
import '../widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  height: 60,
                  width: 60,
                ),
                Logo(
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            SizedBox(height: 15,),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
