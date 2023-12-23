import 'package:flutter/material.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/genre.dart';
import 'package:semster_project/screens/new_screen.dart';
import '../components/components.dart';
import '../sevice/database.dart';

class Genres_Screen extends StatefulWidget {
  const Genres_Screen({super.key});

  @override
  State<Genres_Screen> createState() => _Genres_ScreenState();
}

class _Genres_ScreenState extends State<Genres_Screen> {
  List<Genre>? genreList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseMethods()
        .fetchGenre()
        .then((value) => setState(() => genreList = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: kDrawer(context),
      appBar: AppBar(
        title: ScreenTitle(
          title: "Genre",
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
            itemCount: genreList == null ? 0 : genreList!.length,
            itemBuilder: (BuildContext ctx, index) {
              return genreList == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () => PushNextScreen(
                          context: context,
                          widget: NewScreen(
                            genre: genreList![index].genre,
                          )),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kBackgroundColor,
                            image: DecorationImage(
                                opacity: 1,
                                image: NetworkImage(genreList![index].image),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          genreList![index].genre,
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
  }
}
