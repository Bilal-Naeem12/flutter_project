import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/novelCard.dart';

class NewScreen extends StatefulWidget {
  NewScreen({super.key, required this.text});
  static String id = "new_screen";
  String text;
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final List<Map> myNovels =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              "Novels",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Container(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10),
                itemCount: myNovels.length,
                itemBuilder: (BuildContext ctx, index) {
                  return NovelCard();
                }),
          )),
        ));
  }
}