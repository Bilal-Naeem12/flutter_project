import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
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
    if (widget.novelList!.length == 0) {
      return SizedBox();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 22,
                color: kTextColor,
                fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
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
                          width: 110,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                // Add ClipRRect for border radius
                                borderRadius: BorderRadius.circular(
                                    15.0), // Set your desired border radius
                                child: Image.network(
                                  widget.novelList![index].image_url,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              ClipRRect(
                                // Clip it cleanly.
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    color: Colors.black.withOpacity(0.2),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
          ),
        ],
      );
    }
  }
}
