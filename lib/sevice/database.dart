import 'package:firebase_database/firebase_database.dart';
import 'package:semster_project/components/avatarImg.dart';
import 'package:semster_project/models/genre.dart';
import 'package:semster_project/models/user.dart';

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

  Future<List<String>> fetchGenreString() async {
    List<String> childList = [];
    final databaseRef = FirebaseDatabase.instance.ref("NOVEL/novels");

    DataSnapshot dataSnapshot = await databaseRef.get();

    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        childList.add(element.child("Genre").value.toString());
      });
    }

    return childList;
  }

  Future<List<AvatarImage>> fetchAvatar() async {
    List<AvatarImage> childList = [];
    final databaseRef = FirebaseDatabase.instance.ref("Avatar");

    DataSnapshot dataSnapshot = await databaseRef.get();

    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        childList.add(AvatarImage(img: element.child("img").value.toString()));
      });
    }

    return childList;
  }

  fetchUsers(email) async {
    Usermodel? childList;
    final databaseRef = FirebaseDatabase.instance.ref("user");

    DataSnapshot dataSnapshot = await databaseRef
        .child(email.toString().replaceAll(".com", "_com"))
        .get();

    if (dataSnapshot.exists) {
      childList = Usermodel(
          email: dataSnapshot.child("email").value.toString(),
          password: dataSnapshot.child("password").value.toString(),
          image: dataSnapshot.child("image").value.toString());
    } else {
      childList = null;
    }

    return childList;
  }
}
