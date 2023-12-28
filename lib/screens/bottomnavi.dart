import 'package:flutter/material.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/genres_screens.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/library_screen.dart';
import 'package:semster_project/screens/me_screen.dart';

class BottomNavigation_Screen extends StatefulWidget {
  const BottomNavigation_Screen({super.key});

  @override
  State<BottomNavigation_Screen> createState() =>
      _BottomNavigation_ScreenState();
}

class _BottomNavigation_ScreenState extends State<BottomNavigation_Screen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Library_Screen(),
    Genres_Screen(),
    Me_Screen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: kBottomNavi(_selectedIndex, _onItemTapped));
  }
}
