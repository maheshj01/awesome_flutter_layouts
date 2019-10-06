import 'package:flutter/material.dart';
import 'CustomListView.dart';
import 'Empty_Page.dart';
import 'UserProfile.dart';
import 'EndDrawer.dart';

// import your file here

// Used for CustomListview

List<List<Color>> colors = <List<Color>>[
  [
    Colors.redAccent,
    Colors.red[200],
  ],
  [
    Colors.pinkAccent,
    Colors.pink[200],
  ],
  [
    Colors.orangeAccent,
    Colors.orange[200],
  ],
  [
    Colors.purpleAccent,
    Colors.purple[200],
  ],
  [Colors.cyanAccent, Colors.cyan[200]],
  [
    Colors.yellowAccent,
    Colors.yellow[200],
  ],
];

TextStyle subHeadingTextStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
// add your class name in this list

List layout_list = [
  CustomListView(),
  MyApp(),
  UserProfile(),
  AwesomeEndDrawer(),
];

// add a title to your layout as an identity this will appear in the list View in main.dart

List layout_title = [
  "CustomListView",
  "empty_page",
  "User Profile Page",
  "Awesome end Drawer",
];
// getting Random user data
const String RANDOM_URL = "https://randomuser.me/api/?results=100";

// Used for AwesomeDrawer

List imagetitle = ["Elon Musk"];
List imageurl = [
  "https://everipedia-storage.s3-accelerate.amazonaws.com/ProfilePics/6969909036-1492880896.jpeg",
  "https://i2.wp.com/allcelebrityprofile.com/wp-content/uploads/2015/01/rs_634x768-140902042341-634.Charlize-Theron-Modern-Luxury-JR4-90214-e1531525845675.jpg?fit=622%2C426&ssl=1",
  "https://www.desicomments.com/wp-content/uploads/Smiling-Aditya-Roy-Kapur-236-5.jpg",
];
