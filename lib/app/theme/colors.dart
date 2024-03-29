import 'dart:math';

import 'package:flutter/material.dart';

const colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.white,
  onPrimary: Colors.black87,
  secondary: Colors.black,
  onSecondary: Color(0xFF1d1d1d),
  error: Color(0xffffb4ab),
  onError: Color.fromRGBO(233, 64, 37, 1),
  background: Colors.black,
  onBackground: Color(0xE6000000),
  surface: Color(0xff191113),
  onSurface: Colors.white70,
);

class ActivityColors {
  static const red = Color(0xFFe63c3a);
  static const mint = Color(0xFFc6e7c8);
  static const yellow = Color.fromRGBO(244, 184, 64, 1);
  static const strawberry = Color.fromRGBO(237, 106, 101, 1);
  static const emerald = Color(0xFF00bf8f);
  static const pink = Color.fromRGBO(246, 201, 232, 1);
  static const purple = Color(0xFF8673FE);

  static List<Color> get colors => [red, mint, purple, yellow, strawberry, emerald, pink];

  static Color get random => colors[Random().nextInt(colors.length)];
}
