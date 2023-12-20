import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/validatorFucntions.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/home_screen.dart';
import 'package:semster_project/screens/login_screen.dart';
import 'package:semster_project/screens/welcome_screen.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  Controller() {
    setState(() {
      _write_name = "sadqa";
    });
  }

  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final databaseRef = FirebaseDatabase.instance.ref("NOVEL");
  String _title = "";
  String _write_name = "";
  String _novel_url = "";
  String _image_url = "";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ScreenTitle(title: 'Writer Form'),
        ),
        body: SafeArea(
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
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomFormField(
                                textFormField: TextFormField(
                                  onChanged: (val) => _title = val,

                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(color: Colors.white),
                                  decoration: kTextInputDecorationWriter(
                                      "Title", "Enter Novel Title"),
                                  cursorColor: kTextColor,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) => TextValidator(value),
                                ),
                              ),
                              CustomFormField(
                                textFormField: TextFormField(
                                  onChanged: (val) => _write_name = val,

                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(color: Colors.white),
                                  decoration: kTextInputDecorationWriter(
                                      "Writer Name",
                                      "Enter Novel\'s Write Name"),
                                  cursorColor: kTextColor,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) => TextValidator(value),
                                ),
                              ),
                              CustomFormField(
                                textFormField: TextFormField(
                                  onChanged: (val) => _novel_url = val,

                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(color: Colors.white),
                                  decoration: kTextInputDecorationWriter(
                                      "Novel URL", "Enter Novel URL"),
                                  cursorColor: kTextColor,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) => TextValidator(value),
                                ),
                              ),
                              CustomFormField(
                                textFormField: TextFormField(
                                  onChanged: (val) => _image_url = val,

                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(color: Colors.white),
                                  decoration: kTextInputDecorationWriter(
                                      "Image URL", "Enter Image URL"),
                                  cursorColor: kTextColor,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) => TextValidator(value),
                                ),
                              ),
                              CustomFormField(
                                textFormField: TextFormField(
                                  onChanged: (val) => _description = val,
                                  maxLength: 100,
                                  maxLines: 8,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(color: Colors.white),
                                  decoration: kTextInputDecorationWriter(
                                      "Description", "Enter Novel Descripton"),
                                  cursorColor: kTextColor,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) => TextValidator(value),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomButton(
                                width: 400,
                                buttonText: "Submit",
                                onPressed: () {
                                  try {
                                    if (_formKey.currentState!.validate()) {
                                      String id = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .abs()
                                          .toString()
                                          .substring(5);

                                      databaseRef
                                          .child('novels')
                                          .child(_title.toString())
                                          .set({
                                        "_title": _title.toString(),
                                        "_write_name": "Asdasd",
                                        "_novel_url": _novel_url.toString(),
                                        "_image_url": _image_url.toString(),
                                        "_description": _description.toString(),
                                        "id": int.parse(id)
                                      });
                                      // If the form is valid, display a snackbar. In the real world,
                                      showAlert(
                                              context: context,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WelcomeScreen()));
                                              },
                                              title: 'Congratulation ',
                                              desc: 'Your Novel is Submitted',
                                              alertType: AlertType.success)
                                          .show();
                                    }
                                  } catch (e) {
                                    print(e);
                                  } // Validate returns true if the form is valid, or false otherwise.
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        )
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
