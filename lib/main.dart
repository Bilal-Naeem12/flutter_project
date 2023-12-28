import 'package:flutter/material.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/firebase_options.dart';
import 'package:semster_project/screens/avatar.dart';
import 'package:semster_project/screens/new_screen.dart';
import 'package:semster_project/screens/pdf_read.dart';
import 'package:semster_project/screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              unselectedItemColor: kBackgroundColor),
          drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
          colorScheme: ColorScheme.fromSeed(
              seedColor: kTextColor,
              primary: kTextColor,
              secondary: kTextColor,
              onBackground: kTextColor,
              onPrimaryContainer: kTextColor,
              inversePrimary: kBackgroundColor,
              background: kTextColor,
              secondaryContainer: kTextColor),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          hintColor: kBackgroundColor,
          scaffoldBackgroundColor: Color.fromARGB(255, 29, 29, 29),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'Ubuntu',
            ),
          )),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        SplashPage.id: (context) => const SplashPage(),
        NewScreen.id: (context) => NewScreen()
      },
    );
  }
}
