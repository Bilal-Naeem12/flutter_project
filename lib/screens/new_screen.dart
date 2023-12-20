import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final databaseRef = FirebaseDatabase.instance.ref("NOVEL").child("");
  final List<Map> myNovels =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: ScreenTitle(
          title: "Novels",
        )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Container(child: Text("As"))),
        ));
  }
}


// GridView.builder(
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 400,
//                     childAspectRatio: 2.1,
//                     mainAxisSpacing: 15),
//                 itemCount: myNovels.length,
//                 itemBuilder: (BuildContext ctx, index) {
//                   return NovelCard();
//                 }),