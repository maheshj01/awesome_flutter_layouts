import 'package:flutter/material.dart';
import 'CustomListView.dart';
import 'Empty_Page.dart';

// import your file here

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
      Colors.yellowAccent,
      Colors.yellow[200],
    ],
    [
      Colors.orangeAccent,
      Colors.orange[200],
    ],
    [
      Colors.purpleAccent,
      Colors.purple[200],
    ],
    [Colors.cyanAccent, Colors.cyan[200]]
  ];


  // add your class name in this list

  List layout_list = [CustomListView(),MyApp()];

  // add a title to your layout as an identity this will appear in the list View in main.dart

  List layout_title= ["CustomListView","empty_page"];