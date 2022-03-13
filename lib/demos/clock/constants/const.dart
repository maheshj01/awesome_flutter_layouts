import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:awesome_flutter_layouts/demos/clock/pages/detail.dart';
import 'package:flutter/material.dart';

const double size_sm_4 = 4.0;
const double size_md_6 = 6.0;
const double size_lg_14 = 14.0;
const double size_ex_lg_24 = 24.0;
const double circle_radius = 12.0;

BoxShadow shadowLight = const BoxShadow(
    color: grey, blurRadius: 5, spreadRadius: 1, offset: Offset(0, 1));

BoxShadow searchShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: size_ex_lg_24,
    spreadRadius: 0,
    offset: const Offset(0, 6));

BorderRadius defaultRadius = BorderRadius.circular(circle_radius);

/// sample data for clocks
List<ClockModel> clocks = [
  ClockModel(
    'Digital Clock',
    description,
    price: 200,
    rating: 2,
    material: ClockMaterial.metal,
    image: '$assetsPath/clock_dark.png',
    type: Type.digital,
  ),
  ClockModel(
    'Analog Clock',
    description,
    rating: 1,
    price: 200,
    type: Type.analog,
  ),
  ClockModel(
    'Digital Clock',
    description,
    price: 200,
    rating: 3,
    image: '$assetsPath/minimal_pink.png',
    type: Type.digital,
  ),
  ClockModel(
    'Analog Clock',
    description,
    price: 200,
    rating: 4,
    material: ClockMaterial.metal,
    image: '$assetsPath/clock_dark_pink.png',
    type: Type.analog,
  ),
  ClockModel(
    'Digital Clock',
    description,
    price: 200,
    rating: 5,
    image: '$assetsPath/clock_dark_pink.png',
    type: Type.digital,
  ),
  ClockModel(
    'Analog Clock',
    description,
    price: 200,
    rating: 3,
    image: '$assetsPath/clock_dark_pink.png',
    type: Type.analog,
  ),
];
