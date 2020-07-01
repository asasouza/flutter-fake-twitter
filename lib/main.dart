// flutter
import 'package:flutter/material.dart';
import 'package:flutter_fake_twitter/providers/tweet.dart';
// packages
import 'package:provider/provider.dart';
// screens
import './screens/home.dart';
import './screens/login.dart';
import './screens/settings/name-description.dart';
import './screens/new-tweet.dart';
import './screens/settings/picture.dart';
import './screens/signup/signup-email-user.dart';
import './screens/signup/signup-password.dart';
import './screens/splash.dart';
// helpers
import './helpers/colors.dart';

// providers
import './providers/auth.dart';
import './providers/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (_) => UserProvider(),
          update: (context, auth, user) => UserProvider(
            authToken: auth.token,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, TweetProvider>(
          create: (_) => TweetProvider(),
          update: (context, auth, tweet) => TweetProvider(
            authToken: auth.token,
          ),
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.isAuthenticated
              ? HomeScreen()
              : FutureBuilder(
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                  future: auth.autoLogin(),
                ),
          routes: {
            HomeScreen.routeName: (_) => HomeScreen(),
            NewTweetScreen.routeName: (_) => NewTweetScreen(),
            SettingsNameBioScreen.routeName: (_) => SettingsNameBioScreen(),
            SettingsPictureScreen.routeName: (_) => SettingsPictureScreen(),
            SignupEmailAndUserScreen.routeName: (_) =>
                SignupEmailAndUserScreen(),
            SignupPasswordScreen.routeName: (_) => SignupPasswordScreen(),
          },
          title: 'Flutter FakeTwitter',
          theme: ThemeData(
            accentColor: ColorsHelper.lightBlue,
            appBarTheme: AppBarTheme(
              brightness: Brightness.dark,
              elevation: 0,
              iconTheme: IconThemeData(
                color: ColorsHelper.lightBlue,
              ),
            ),
            dividerTheme: DividerThemeData(
              color: ColorsHelper.lightGray,
              thickness: 0.2,
            ),
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
            snackBarTheme: SnackBarThemeData(
              backgroundColor: ColorsHelper.darkGray.withOpacity(0.3),
              contentTextStyle: TextStyle(
                color: ColorsHelper.white,
                fontFamily: 'Roboto',
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
