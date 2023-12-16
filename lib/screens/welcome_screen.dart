import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semster_project/screens/genres_screens.dart';
import 'package:semster_project/screens/home_screen.dart';
import '../components/components.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: CustomContainer(title: "Writer", icon: Icons.edit),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                child: CustomContainer(title: "Reader", icon: Icons.menu_book),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Genres_Screen())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
