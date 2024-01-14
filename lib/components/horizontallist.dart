import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/novel_detail_screen.dart';

class HorizontalList extends StatefulWidget {
  HorizontalList({super.key, required this.novelList, this.title = "Recents"});
  List<Novel>? novelList;
  String title;
  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(
          height: 190.0,
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount:
                  widget.novelList == null ? 0 : widget.novelList!.length,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                    onTap: () => PushNextScreen(
                        context: context,
                        widget: NovelDetailScreen(
                          novel: widget.novelList![index],
                          genre: widget.novelList![index].genre,
                        )),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                      width: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(widget.novelList![index].image_url,
                              fit: BoxFit.contain),
                          ClipRRect(
                            // Clip it cleanly.
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Container(
                                color: Colors.black.withOpacity(0.3),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.novelList![index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              }),
        ),
      ],
    );
  }
}
