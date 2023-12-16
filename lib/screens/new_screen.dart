import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  NewScreen({super.key, required this.text});
  String text;
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Text(widget.text),
      )),
    );
  }
}
