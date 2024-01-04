import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/novelCard.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/novel.dart';

class NewScreen extends StatefulWidget {
  NewScreen({super.key, this.genre = "Horror"});
  static String id = "new_screen";
  String genre;
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final databaseRef = FirebaseDatabase.instance.ref("NOVEL").child("novels");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: ScreenTitle(
          title: "Novels",
        )),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FirebaseAnimatedList(
              query: databaseRef.child(widget.genre),
              itemBuilder: (context, snapshot, animation, index) {
                if (snapshot.hasChild("Genre") || snapshot.hasChild("Image")) {
                  return Text("");
                }

                String description =
                    snapshot.child('_description').value.toString();
                String like = snapshot.child('_likes').value.toString();
                String img = snapshot.child('_image_url').value.toString();
                String novel = snapshot.child('_novel_url').value.toString();
                String title = snapshot.child('_title').value.toString();
                String writer_name =
                    snapshot.child('_writer_naem').value.toString();
                bool approved =
                    bool.parse(snapshot.child('_approved').value.toString());

                if (approved || ActiveUser.active!.isSuperUser) {
                  return NovelCard(
                    genre: widget.genre,
                    novel: Novel(
                      approved: approved,
                      likes: int.parse(like),
                      description: description,
                      title: title,
                      image_url: img,
                      novel_url: novel,
                      writer: writer_name,
                    ),
                  );
                }
                return Text("");
              },
            )));
  }
}
