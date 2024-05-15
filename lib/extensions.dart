import 'package:flutter/material.dart';

extension ColorToString on Color {
  String toColorString() {
    if (this == Colors.blue) return 'blue';
    if (this == Colors.red) return 'red';
    if (this == Colors.green) return 'green';
    if (this == Colors.purple) return 'purple';
    if (this == Colors.orange) return 'orange';
    if (this == Colors.teal) return 'teal';
    if (this == Colors.pink) return 'pink';
    if (this == Colors.indigo) return 'indigo';
    if (this == Colors.brown) return 'brown';
    if (this == Colors.cyan) return 'cyan';
    if (this == Colors.deepOrange) return 'deepOrange';
    if (this == Colors.deepPurple) return 'deepPurple';
    if (this == Colors.lime) return 'lime';
    if (this == Colors.amber) return 'amber';
    if (this == Colors.lightBlue) return 'lightBlue';
    if (this == Colors.lightGreen) return 'lightGreen';
    if (this == Colors.yellow) return 'yellow';
    if (this == Colors.grey) return 'grey';
    return 'unknown'; // If color is not one of the predefined colors
  }
}
