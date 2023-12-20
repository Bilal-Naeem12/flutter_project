import 'package:flutter/material.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/new_screen.dart';
import '../components/components.dart';

class Genres_Screen extends StatefulWidget {
  const Genres_Screen({super.key});

  @override
  State<Genres_Screen> createState() => _Genres_ScreenState();
}

class _Genres_ScreenState extends State<Genres_Screen> {
  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () => PushNextScreen(
                    context: context,
                    widget: NewScreen(text: index.toString())),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      image: DecorationImage(
                          opacity: 1,
                          image: NetworkImage(
                              "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/fa0a2175305113.5c48c4442b973.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "Horror",
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
