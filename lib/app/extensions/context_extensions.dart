import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}
