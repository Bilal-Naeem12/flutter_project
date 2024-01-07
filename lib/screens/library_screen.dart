import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10),
            itemCount: novelList == null ? 0 : novelList!.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                  onTap: () => PushNextScreen(
                      context: context,
                      widget: NovelDetailScreen(
                        novel: novelList![index],
                        genre: novelList![index].genre,
                      )),
                  child: Container(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(novelList![index].image_url,
                            fit: BoxFit.contain),
                        ClipRRect(
                          // Clip it cleanly.
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              color: Colors.black.withOpacity(0.4),
                              alignment: Alignment.center,
                              child: Text(
                                novelList![index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    );
    ;
  }
}
