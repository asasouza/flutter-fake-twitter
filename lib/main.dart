import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
              title: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          elevation: 1,
        ),
        dividerColor: Colors.grey.shade200,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'Fake Twitter',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          margin: EdgeInsets.only(top: 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'This is my Fake Twitter App',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
