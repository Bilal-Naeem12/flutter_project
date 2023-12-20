import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/novelCard.dart';
import 'package:semster_project/models/novel.dart';

class NewScreen extends StatefulWidget {
  NewScreen({super.key, required this.text});
  static String id = "new_screen";
  String text;
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final databaseRef = FirebaseDatabase.instance.ref("NOVEL").child("novels");

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
              query: databaseRef,
              itemBuilder: (context, snapshot, animation, index) {
                String description =
                    snapshot.child('_description').value.toString();
                String img = snapshot.child('_image_url').value.toString();
                String novel = snapshot.child('_novel_url').value.toString();
                String title = snapshot.child('_title').value.toString();
                String writer_name =
                    snapshot.child('_writer_naem').value.toString();
                String id = snapshot.child('1402954').value.toString();
                return NovelCard(
                  novel: Novel(
                    description: description,
                    title: title,
                    image_url: img,
                    novel_url: novel,
                    writer: writer_name,
                  ),
                );
              },
            )));
  }
}
