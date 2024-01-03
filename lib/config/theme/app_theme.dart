import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.white,
      //colorSchemeSeed: const Color(0xFF020471),
      brightness: Brightness.dark);
}
