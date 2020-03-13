// flutter
import 'package:flutter/material.dart';
// screens
import './screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Color.fromRGBO(29, 161, 242, 1),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          elevation: 0,
        ),
        dividerColor: Colors.grey.shade700,
        primarySwatch: MaterialColor(0xFF151F2A, {
          50: Color.fromRGBO(21, 31, 42, .1),
          100: Color.fromRGBO(21, 31, 42, .2),
          200: Color.fromRGBO(21, 31, 42, .3),
          300: Color.fromRGBO(21, 31, 42, .4),
          400: Color.fromRGBO(21, 31, 42, .5),
          500: Color.fromRGBO(21, 31, 42, .6),
          600: Color.fromRGBO(21, 31, 42, .7),
          700: Color.fromRGBO(21, 31, 42, .8),
          800: Color.fromRGBO(21, 31, 42, .9),
          900: Color.fromRGBO(21, 31, 42, 1),
        }),
        textTheme: ThemeData.dark().textTheme.copyWith(
              body1: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 15,
              ),
              body2: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 15,
              ),
              subhead: TextStyle(
                color: Color.fromRGBO(29, 161, 242, 1),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              title: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
      ),
    );
  }
}
