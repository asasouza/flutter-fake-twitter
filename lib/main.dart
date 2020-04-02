// flutter
import 'package:flutter/material.dart';
// packages
import 'package:provider/provider.dart';
// screens
import './screens/home.dart';
import './screens/login.dart';
import './screens/settings/name-description.dart';
import './screens/signup/signup-email-user.dart';
import './screens/signup/signup-password.dart';
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
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: auth.isAuthenticated ? HomeScreen() : LoginScreen(),
          home: SettingsNameBio(),
          routes: {
            SettingsNameBio.routeName: (_) => SettingsNameBio(),
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
        ),
      ),
    );
  }
}
