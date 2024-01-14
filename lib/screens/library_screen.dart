import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/ads/bannerAd.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/horizontallist.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/novel_detail_screen.dart';
import 'package:semster_project/screens/novel_screen.dart';
import 'package:semster_project/screens/pdf_read.dart';
import 'package:semster_project/sevice/database.dart';

class Library_Screen extends StatefulWidget {
  const Library_Screen({super.key});

  @override
  State<Library_Screen> createState() => _Library_ScreenState();
}

class _Library_ScreenState extends State<Library_Screen> {
  List<Novel>? novelList;
  bool isLoading = true;
  DatabaseReference? databaseNovelRef;
  List<Novel>? likedNovels;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseMethods()
        .fetchLikedNovels()
        .then((value) => setState(() {
              likedNovels = value;
            }))
        .then((value) => null);
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        isLoading = false;
      });
    });

    DatabaseMethods().fetchNewNovels().then((value) => setState(() {
          novelList = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const ScreenTitle(
          title: "Library",
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const BannerExample(),
                    HorizontalList(
                      title: "Added Recently ",
                      novelList: novelList,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    HorizontalList(
                      novelList: likedNovels,
                      title: "Liked Novels",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    HorizontalList(
                      novelList: likedNovels,
                      title: "Trending",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
