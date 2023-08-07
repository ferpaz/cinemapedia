import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData() => ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}