import 'package:firebase_database/firebase_database.dart';

class DatabaseMethods {
  Future addUser(String uid, Map<String, dynamic> userInfoMap) {
    return FirebaseDatabase.instance.ref("users").child(uid).set(userInfoMap);
  }
}
