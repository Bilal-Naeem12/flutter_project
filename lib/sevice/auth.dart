import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/user.dart';
import 'package:semster_project/screens/welcome_screen.dart';
import 'package:semster_project/sevice/database.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUser() async {
    return auth.currentUser;
  }

  singout() async {
    await auth.signOut();
  }

  signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await auth.signInWithCredential(credential);
    User? userDetails = result.user;
    Map<String, dynamic> userInfoMap = {
      "email": userDetails!.email,
      "username": userDetails.displayName,
      "image": userDetails.photoURL,
      "id": userDetails.uid
    };
    ActiveUser.active = Usermodel(
        username: userInfoMap["username"],
        email: userInfoMap["email"],
        password: "null",
        image: userInfoMap["image"]);
    await DatabaseMethods().addUser(userDetails.uid, userInfoMap).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });
  }
}
