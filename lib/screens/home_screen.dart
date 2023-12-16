import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/sevice/auth.dart';
import '../components/components.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static String id = 'home_screen';
  final databaseRef = FirebaseDatabase.instance
      .refFromURL("https://semster-project-17412-default-rtdb.firebaseio.com/");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/home.jpg',
                        height: 270,
                      ),
                      const ScreenTitle(title: 'YELLOOO'),
                      const Text(
                        'Welcome to Tasky, where you manage your daily tasks',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Hero(
                        tag: 'login_btn',
                        child: CustomButton(
                          buttonText: 'Login',
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Hero(
                        tag: 'signup_btn',
                        child: CustomButton(
                          buttonText: 'Sign Up',
                          isOutlined: true,
                          onPressed: () {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Sign up using',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              radius: 25,
                              child: Image.asset(
                                  'assets/images/icons/facebook.png'),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              AuthMethods().signInWithGoogle(context);
                            },
                            icon: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child:
                                  Image.asset('assets/images/icons/google.png'),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              databaseRef
                                  .child('user')
                                  .child("Asdassdasd")
                                  .set({
                                "email": "Adssasdasd",
                                "password": "asdasdsadsad",
                                "createdAt": DateTime.now().toString()
                              });
                            },
                            icon: CircleAvatar(
                              radius: 25,
                              child: Image.asset(
                                  'assets/images/icons/linkedin.png'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
