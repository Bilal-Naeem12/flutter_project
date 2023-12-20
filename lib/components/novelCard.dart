import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/pdf_read.dart';

class NovelCard extends StatefulWidget {
  const NovelCard({super.key, required this.novel});
  final Novel novel;
  @override
  State<NovelCard> createState() => _NovelCardState();
}

class _NovelCardState extends State<NovelCard> {
  bool isClicked = false;
  int counter = 23;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => PDF_Reader())),
      child: Card(
        shadowColor: kTextColor,
        color: kBackgroundColor,
        elevation: 2,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.novel.image_url,
                width: 100,
                height: 180,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 250,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.novel.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      new Text(
                        widget.novel.description.toString() + "....",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          color: const Color.fromARGB(255, 82, 80, 80),
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked;
                                    if (isClicked != false) {
                                      counter = counter + 1;
                                    } else {
                                      counter = counter - 1;
                                    }
                                  });
                                },
                                icon: Icon(
                                  isClicked == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                )),
                            Text(counter.toString())
                          ],
                        ),
                      ])
                    ]),
              )
            ]),
      ),
    );
  }
}
