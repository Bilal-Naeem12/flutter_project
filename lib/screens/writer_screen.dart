import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
  final databaseRef = FirebaseDatabase.instance.ref("writers");
  late String _title;
  late String _write_name;
  late String _novel_url;
  late String _image_url;
  late String _description;
  bool _saving = false;
  String id = "";

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
                                  height: 20,
                                ),
                                CustomFormField(
                                  formTitle: "Title",
                                  textField: TextField(
                                    decoration:
                                        kTextInputDecorationWriter.copyWith(
                                      hintText: 'Enter novel\'s title',
                                    ),
                                    onChanged: (value) {
                                      _title = value;
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
                                      _write_name = value;
                                    },
                                    style: const TextStyle(
                                        fontSize: 20, color: kBackgroundColor),
                                  ),
                                ),
                                CustomFormField(
                                  formTitle: "Novel URL",
                                  textField: TextField(
                                    decoration:
                                        kTextInputDecorationWriter.copyWith(
                                      hintText: 'Enter novel\'s URL',
                                    ),
                                    onChanged: (value) {
                                      _novel_url = value;
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
                                      _image_url = value;
                                    },
                                    style: const TextStyle(
                                        fontSize: 20, color: kBackgroundColor),
                                  ),
                                ),
                                CustomFormField(
                                  height: 200,
                                  formTitle: "Description",
                                  textField: TextField(
                                    onChanged: (value) {
                                      _description = value;
                                    },
                                    maxLines: null,
                                    expands: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration:
                                        kTextInputDecorationWriter.copyWith(
                                            hintText:
                                                'Enter description of the novel'),
                                    style: const TextStyle(
                                        fontSize: 20, color: kBackgroundColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomBottomScreen(
                                  textButton: 'Submit',
                                  heroTag: 'Submit',
                                  question: '',
                                  buttonPressed: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    setState(() {
                                      _saving = true;
                                    });
                                    try {
                                      id = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .abs()
                                          .toString()
                                          .substring(5);

                                      databaseRef
                                          .child('writer')
                                          .child(_title.toString())
                                          .set({
                                        "title": _title.toString(),
                                        "writer": _write_name.toString(),
                                        "novel_url": _novel_url.toString(),
                                        "image_url": _image_url.toString(),
                                        "description": _description.toString(),
                                        "createdAt": DateTime.now().toString(),
                                        "id": id
                                      });

                                      Alert(
                                        closeIcon: Container(),
                                        context: context,
                                        buttons: [
                                          DialogButton(
                                            onPressed: () {},
                                            width: 120,
                                            child: Text(
                                              "Submitted",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      );
                                    } catch (e) {
                                      // ignore: use_build_context_synchronously
                                      signUpAlert(
                                        context: context,
                                        onPressed: () {
                                          setState(() {
                                            _saving = false;
                                          });
                                        },
                                        title: 'Form Not Submit',
                                        desc:
                                            'Unable to submit the form please try again',
                                        btnText: 'Try Now',
                                      ).show();
                                    }
                                  },
                                  questionPressed: () {
                                    signUpAlert(
                                      onPressed: () async {},
                                      title: 'RESET YOUR PASSWORD',
                                      desc:
                                          'Click on the button to reset your password',
                                      btnText: 'Reset Now',
                                      context: context,
                                    ).show();
                                  },
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
