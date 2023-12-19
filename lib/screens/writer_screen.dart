import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/home_screen.dart';
import 'package:semster_project/screens/login_screen.dart';
import 'package:semster_project/screens/welcome_screen.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final databaseRef = FirebaseDatabase.instance.ref("writer");
  late String _email;
  late String _password;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return false;
      },
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 360,
                      child: Column(
                        children: [
                          const ScreenTitle(title: 'Writer Form'),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                CustomFormField(
                                  formTitle: "Title",
                                  textField: TextField(
                                    decoration:
                                        kTextInputDecorationWriter.copyWith(
                                      hintText: 'Enter novel\'s title',
                                    ),
                                    onChanged: (value) {
                                      _email = value;
                                    },
                                    style: const TextStyle(
                                        fontSize: 20, color: kBackgroundColor),
                                  ),
                                ),
                                CustomFormField(
                                  formTitle: "Writer Name",
                                  textField: TextField(
                                    decoration:
                                        kTextInputDecorationWriter.copyWith(
                                      hintText: 'Enter novel\'s writer name',
                                    ),
                                    onChanged: (value) {
                                      _email = value;
                                    },
                                    style: const TextStyle(
                                        fontSize: 20, color: kBackgroundColor),
                                  ),
                                ),
                                CustomFormField(
                                  formTitle: "Image URL",
                                  textField: TextField(
                                    decoration:
                                        kTextInputDecorationWriter.copyWith(
                                      hintText: 'Enter novel\'s image URL',
                                    ),
                                    onChanged: (value) {
                                      _email = value;
                                    },
                                    style: const TextStyle(
                                        fontSize: 20, color: kBackgroundColor),
                                  ),
                                ),
                                CustomFormField(
                                  formTitle: "Description",
                                  textField: TextField(
                                    decoration:
                                        kTextInputDecorationWriter.copyWith(
                                            hintText:
                                                'Enter description of the novel'),
                                    onChanged: (value) {
                                      _email = value;
                                    },
                                    style: const TextStyle(
                                        fontSize: 20, color: kBackgroundColor),
                                  ),
                                ),
                              ]),
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
    );
  }
}
