import 'package:flutter/material.dart';

const double size_sm_4 = 4.0;
const double size_md_6 = 6.0;
const double size_lg_14 = 14.0;
const double size_ex_lg_24 = 24.0;
const double circle_radius = 12.0;

BoxShadow shadowLight = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 5,
    spreadRadius: 1,
    offset: const Offset(0, 1));

BoxShadow searchShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: size_ex_lg_24,
    spreadRadius: 0,
    offset: const Offset(0, 6));

BorderRadius defaultRadius = BorderRadius.circular(circle_radius);
