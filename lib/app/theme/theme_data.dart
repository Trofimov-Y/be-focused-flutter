import 'package:be_focused/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.urbanistTextTheme(),
  listTileTheme: const ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  ),
);
