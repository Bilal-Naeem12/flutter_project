import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/new_screen.dart';
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
        title: const ScreenTitle(
          title: "Library",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10),
            itemCount: novelList == null ? 0 : novelList!.length,
            itemBuilder: (BuildContext ctx, index) {
              return novelList == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () => PushNextScreen(
                          context: context,
                          widget: NewScreen(
                            genre: novelList![index].title,
                          )),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kBackgroundColor,
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken),
                                image:
                                    NetworkImage(novelList![index].image_url),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          novelList![index].title,
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.italic,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kBackgroundColor),
                        ),
                      ),
                    );
            }),
      ),
    );
    ;
  }
}
