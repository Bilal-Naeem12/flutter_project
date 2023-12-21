import 'package:firebase_database/firebase_database.dart';
import 'package:semster_project/models/genre.dart';

class DatabaseMethods {
  Future addUser(String uid, Map<String, dynamic> userInfoMap) {
    return FirebaseDatabase.instance.ref("users").child(uid).set(userInfoMap);
  }

  Future<List<Genre>> fetchGenre() async {
    List<Genre> childList = [];
    final databaseRef = FirebaseDatabase.instance.ref("NOVEL/novels");

    DataSnapshot dataSnapshot = await databaseRef.get();

    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        childList.add(Genre(
            genre: element.child("Genre").value.toString(),
            image: element.child("Image").value.toString()));
      });
    }

    return childList;
  }
}
