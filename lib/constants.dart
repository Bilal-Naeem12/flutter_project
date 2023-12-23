import 'package:flutter/material.dart';
import 'package:semster_project/components/avatarImg.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/user.dart';
import 'package:semster_project/screens/login_screen.dart';

const Color kBackgroundColor = Color.fromARGB(255, 255, 255, 255);
const Color kTextColor = Color.fromARGB(255, 163, 211, 32);
const Color kErrorColor = Color.fromARGB(255, 255, 0, 0);
const InputDecoration kTextInputDecoration = InputDecoration(
  border: InputBorder.none,
  hintText: '',
  // ),
);

InputDecoration kTextInputDecorationWriter(labelText, hintText,
    {floatingLabelBehavior = FloatingLabelBehavior.auto}) {
  return InputDecoration(
    errorStyle: TextStyle(fontSize: 15, color: kErrorColor),
    labelStyle: TextStyle(color: Colors.white, fontSize: 22),
    hintStyle:
        TextStyle(fontSize: 15, color: kBackgroundColor.withOpacity(0.7)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: kTextColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: kErrorColor),
    ),
    labelText: labelText,
    hintText: hintText,
    floatingLabelBehavior: floatingLabelBehavior,
  );
}

Drawer kDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(
              color: kTextColor,
            ),
            child: AvatarImage(img: ActiveUser.active!.image)),
        SizedBox(
          height: 10,
        ),
        klistTile(text: "Setting", onTap: () {}, icon: Icons.settings),
        SizedBox(
          height: 20,
        ),
        klistTile(text: "Profile", onTap: () {}, icon: Icons.person),
        SizedBox(
          height: 300,
        ),
        Container(
          width: 100,
          child: CustomButton(
            buttonText: "Logout",
            onPressed: () {
              ActiveUser.active = null;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        )
      ],
    ),
  );
}

TextStyle ktextStyle() {
  return TextStyle(fontSize: 20, color: kTextColor);
}

ListTile klistTile({text, onTap, icon}) {
  return ListTile(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(60))),
    tileColor: kBackgroundColor,
    onTap: onTap,
    trailing: Icon(
      Icons.arrow_forward,
      color: kTextColor,
    ),
    title: Row(
      children: [
        Icon(
          icon,
          color: kTextColor,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: ktextStyle(),
        ),
      ],
    ),
  );
}
