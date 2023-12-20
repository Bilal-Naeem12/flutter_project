import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/validatorFucntions.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/home_screen.dart';
import 'package:semster_project/screens/login_screen.dart';
import 'package:semster_project/screens/welcome_screen.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

// id = DateTime.now()
//                                         .millisecondsSinceEpoch
//                                         .abs()
//                                         .toString()
//                                         .substring(5);

//                                     databaseRef
//                                         .child('writer')
//                                         .child(_title.toString())
//                                         .set({
//                                       "title": _title.toString(),
//                                       "writer": _write_name.toString(),
//                                       "novel_url": _novel_url.toString(),
//                                       "image_url": _image_url.toString(),
//                                       "description": _description.toString(),
//                                       "createdAt": DateTime.now().toString(),
//                                       "id": id
//                                     });

class _WriteScreenState extends State<WriteScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final databaseRef = FirebaseDatabase.instance.ref("writers");
  late String _title;
  late String _write_name;
  late String _novel_url;
  late String _image_url;
  late String _description;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
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
                                  labelText: "Title",
                                  hintText: "Enter Novel Title"),
                              CustomFormField(
                                  labelText: "Writer Name",
                                  hintText: "Enter Novel\'s Write Name"),
                              CustomFormField(
                                  labelText: "Image URL",
                                  hintText: "Enter Novel URL"),
                              CustomFormField(
                                  maxLength: 100,
                                  maxLines: 8,
                                  labelText: "Description",
                                  hintText: "Enter Novel Descripton"),
                              SizedBox(
                                height: 40,
                              ),
                              CustomButton(
                                width: 400,
                                buttonText: "Submit",
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    showAlert(
                                            context: context,
                                            onPressed: () {
                                              Navigator.popAndPushNamed(
                                                  context, WelcomeScreen.id);
                                            },
                                            title: 'Congratulation ',
                                            desc: 'Your Novel is Submitted',
                                            alertType: AlertType.success)
                                        .show();
                                  }
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
