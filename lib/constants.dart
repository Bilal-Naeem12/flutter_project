import 'package:flutter/material.dart';

const Color kBackgroundColor = Color.fromARGB(255, 255, 255, 255);
const Color kTextColor = Color.fromARGB(255, 163, 211, 32);
const Color kErrorColor = Color.fromARGB(255, 255, 0, 0);
const InputDecoration kTextInputDecoration = InputDecoration(
  border: InputBorder.none,
  hintText: '',
  // ),
);

InputDecoration kTextInputDecorationWriter = InputDecoration(
    hintStyle:
        TextStyle(fontSize: 15, color: kBackgroundColor.withOpacity(0.7)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    labelText: 'Default TextField',
    hintText: "asd",
    enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
