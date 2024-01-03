import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/pdf_read.dart';
import 'package:semster_project/sevice/database.dart';

class NovelCard extends StatefulWidget {
  const NovelCard({super.key, required this.novel, required this.genre});
  final Novel novel;
  final String genre;

  @override
  State<NovelCard> createState() => _NovelCardState();
}

class _NovelCardState extends State<NovelCard> {
  bool isClicked = false;
  int counter = 0;
  DatabaseReference? databaseUserRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      databaseUserRef = ActiveUser.isGoogle
          ? FirebaseDatabase.instance
              .ref("users/${ActiveUser.active!.id}/liked_novel")
          : FirebaseDatabase.instance.ref(
              "user/${ActiveUser.active!.email.replaceAll(".com", "_com")}/liked_novel");

      counter = widget.novel.likes;
    });

    DatabaseMethods()
        .isLikedNovel(widget.novel.title, databaseUserRef)
        .then((value) => setState(() => isClicked = value));
  }

  @override
  Widget build(BuildContext context) {
    final databaseRef = FirebaseDatabase.instance
        .ref("NOVEL")
        .child("novels/${widget.genre}/${widget.novel.title}");

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PDF_Reader(novel_url: widget.novel.novel_url))),
      child: Card(
        shadowColor: kTextColor,
        color: kBackgroundColor,
        elevation: 5,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.novel.image_url,
                width: 100,
                height: 180,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 250,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.novel.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      new Text(
                        widget.novel.description.toString().substring(0, 100) +
                            "....",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          color: const Color.fromARGB(255, 82, 80, 80),
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked;
                                    if (isClicked != false) {
                                      counter = counter + 1;
                                      databaseRef!.update(
                                          {"_likes": counter.toString()});
                                      databaseUserRef!
                                          .child(widget.novel.title)!
                                          .set({
                                        "novel_title": widget.novel.title
                                      });
                                    } else {
                                      counter = counter - 1;
                                      databaseRef!.update(
                                          {"_likes": counter.toString()});
                                      databaseUserRef!
                                          .child(widget.novel.title)
                                          .remove();
                                    }
                                  });
                                },
                                icon: Icon(
                                  isClicked == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                )),
                            Text(counter.toString())
                          ],
                        ),
                      ])
                    ]),
              )
            ]),
      ),
    );
  }
}
