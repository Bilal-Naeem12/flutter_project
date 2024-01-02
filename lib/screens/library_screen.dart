import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/new_screen.dart';
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
                childAspectRatio: 0.8,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10),
            itemCount: novelList == null ? 0 : novelList!.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () => PushNextScreen(
                    context: context,
                    widget: PDF_Reader(novel_url: novelList![index].novel_url)),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    image: DecorationImage(
                        image: NetworkImage(novelList![index].image_url),
                        fit: BoxFit.cover),
                  ),
                ),
              );
            }),
      ),
    );
    ;
  }
}
