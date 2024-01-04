import 'package:flutter/material.dart';
import 'package:semster_project/components/avatarImg.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/user.dart';
import 'package:semster_project/screens/changep_screen.dart';
import 'package:semster_project/screens/edit_profile.dart';
import 'package:semster_project/screens/login_screen.dart';
import 'package:semster_project/screens/writer_screen.dart';
import 'package:semster_project/sevice/auth.dart';

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

ListView kListView(BuildContext context) {
  return ListView(
    children: [
      DrawerHeader(
          decoration: BoxDecoration(
            color: kTextColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarImage(img: ActiveUser.active!.image),
              SizedBox(
                height: 4,
              ),
              Text(
                ActiveUser.active!.username.toUpperCase(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
              )
            ],
          )),
      ActiveUser.isGoogle
          ? SizedBox()
          : klistTile(
              text: "My Account",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen()));
              },
              icon: Icons.person),
      ActiveUser.isGoogle
          ? SizedBox()
          : klistTile(
              text: "Change Password",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePassworrdScreen()));
              },
              icon: Icons.password),
      klistTile(
          text: "Become Writer",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WriteScreen()));
          },
          icon: Icons.edit),
      klistTile(text: "About Us", onTap: () {}, icon: Icons.chat_bubble),
      klistTile(
          text: "Logout",
          onTap: () {
            if (ActiveUser.active!.email.contains(".com")) {
              AuthMethods().singout();
              print("truuu kahaeee");
            }
            ActiveUser.active = null;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          icon: Icons.logout),
    ],
  );
}

TextStyle ktextStyle() {
  return TextStyle(fontSize: 20, color: kTextColor);
}

ListTile klistTile({text, onTap, icon}) {
  return ListTile(
    visualDensity: VisualDensity(vertical: 4),
    tileColor: Color.fromARGB(255, 29, 29, 29),
    onTap: onTap,
    trailing: Icon(
      Icons.arrow_forward_ios,
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
