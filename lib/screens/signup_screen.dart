import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/components.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final databaseRef = FirebaseDatabase.instance
      .refFromURL("https://semster-project-17412-default-rtdb.firebaseio.com/");
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  late String _confirmPass;
  var id = "";
  bool _saving = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return true;
      },
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 360,
                    height: 334,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ScreenTitle(title: 'Sign Up'),
                        CustomTextField(
                          textField: TextField(
                            onChanged: (value) {
                              _email = value;
                            },
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: kTextInputDecoration.copyWith(
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        CustomTextField(
                          textField: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              _password = value;
                            },
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: kTextInputDecoration.copyWith(
                              hintText: 'Password',
                            ),
                          ),
                        ),
                        CustomTextField(
                          textField: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              _confirmPass = value;
                            },
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: kTextInputDecoration.copyWith(
                              hintText: 'Confirm Password',
                            ),
                          ),
                        ),
                        CustomBottomScreen(
                          textButton: 'Sign Up',
                          heroTag: 'signup_btn',
                          question: 'Have an account?',
                          buttonPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              _saving = true;
                            });
                            if (_confirmPass == _password) {
                              try {
                                setState(() {
                                  id = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .abs()
                                      .toString()
                                      .substring(5);
                                });
                                UserCredential uc =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: _email, password: _password);

                                databaseRef.child('user').child(id).set({
                                  "email": _email.toString(),
                                  "password": _password.toString(),
                                  "createdAt": DateTime.now().toString(),
                                  "id": id
                                });

                                if (context.mounted) {
                                  signUpAlert(
                                    context: context,
                                    title: 'GOOD JOB',
                                    desc: 'Go login now',
                                    btnText: 'Login Now',
                                    onPressed: () {
                                      setState(() {
                                        _saving = false;
                                        Navigator.popAndPushNamed(
                                            context, SignUpScreen.id);
                                      });
                                      Navigator.pushNamed(
                                          context, LoginScreen.id);
                                    },
                                  ).show();
                                }
                              } catch (e) {
                                signUpAlert(
                                    context: context,
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                    title: 'SOMETHING WRONG',
                                    desc: 'Close the app and try again',
                                    btnText: 'Close Now');
                              }
                            } else {
                              showAlert(
                                  context: context,
                                  title: 'WRONG PASSWORD',
                                  desc:
                                      'Make sure that you write the same password twice',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }).show();
                            }
                          },
                          questionPressed: () async {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
