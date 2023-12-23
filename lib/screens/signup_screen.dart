import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semster_project/components/validatorFucntions.dart';
import 'package:semster_project/models/user.dart';
import 'package:semster_project/screens/avatar.dart';
import '../components/components.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

import '../constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String _email;
  late String _password;
  late String _confirmPass;
  final _formKey = GlobalKey<FormState>();
  var id = "";
  late Usermodel user;
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
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 360,
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const ScreenTitle(title: 'Sign Up'),
                                  CustomFormField(
                                    textFormField: TextFormField(
                                      style: TextStyle(color: kBackgroundColor),
                                      validator: (val) => EmailValidator(val),
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                      decoration: kTextInputDecorationWriter(
                                          "Email", "Enter Email"),
                                    ),
                                  ),
                                  CustomFormField(
                                    textFormField: TextFormField(
                                      style: TextStyle(color: kBackgroundColor),
                                      validator: (val) => TextValidator(val),
                                      obscureText: true,
                                      onChanged: (value) {
                                        _password = value;
                                      },
                                      decoration: kTextInputDecorationWriter(
                                          "Password", "Enter Password"),
                                    ),
                                  ),
                                  CustomFormField(
                                    textFormField: TextFormField(
                                      style: TextStyle(color: kBackgroundColor),
                                      validator: (val) => TextValidator(val),
                                      obscureText: true,
                                      onChanged: (value) {
                                        _confirmPass = value;
                                      },
                                      decoration: kTextInputDecorationWriter(
                                          "Confirm Password", "Enter Password"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            CustomBottomScreen(
                              textButton: 'Sign Up',
                              heroTag: 'signup_btn',
                              question: 'Have an account?',
                              buttonPressed: () {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    if (_confirmPass == _password) {
                                      setState(() {
                                        user = Usermodel(
                                            email: _email, password: _password);
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Avatar_Screen(user: user)));
                                    } else {
                                      signUpAlert(
                                        onPressed: () async {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        title: 'Password Not Match',
                                        btnText: 'Try Again',
                                        context: context,
                                      ).show();
                                    }
                                  }
                                } catch (e) {
                                  print(e);
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
        ),
      ),
    );
  }
}
