// flutter
import 'package:flutter/material.dart';
// screens
import './screens/login.dart';
// helpers
import './helpers/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: ColorsHelper.lightBlue,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          elevation: 0,
        ),
        dividerColor: ColorsHelper.lightGray,
        primarySwatch: ColorsHelper.darkBlue,
        textTheme: ThemeData.dark().textTheme.copyWith(
              body1: TextStyle(
                color: ColorsHelper.white,
                fontFamily: 'Roboto',
                fontSize: 15,
              ),
              body2: TextStyle(
                color: ColorsHelper.white,
                fontFamily: 'Roboto',
                fontSize: 18,
              ),
              subhead: TextStyle(
                color: ColorsHelper.lightBlue,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              title: TextStyle(
                color: ColorsHelper.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
              display1: TextStyle(
                color: ColorsHelper.darkGray,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
      ),
    );
  }
}
