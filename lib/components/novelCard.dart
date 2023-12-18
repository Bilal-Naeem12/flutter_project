import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/screens/pdf_read.dart';

class NovelCard extends StatefulWidget {
  const NovelCard({super.key});

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
        elevation: 2,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "https://marketplace.canva.com/EAFPpkFj4is/1/0/1003w/canva-7clVjOZ2o_Y.jpg",
                width: 100,
                height: 150,
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
                        "Love By OLIVIA",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      new Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                                .toString()
                                .substring(0, 120) +
                            "....",
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
