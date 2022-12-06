import 'package:flutter/material.dart';
import 'package:flutter_market_app/themes/theme_colors.dart';

ThemeData myTheme = ThemeData(
  primarySwatch: ThemeColors.primaryColor,
  primaryColor: ThemeColors.primaryColor,
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w900, color: Colors.white),
    titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: ThemeColors.greyAccent),
    bodyLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: ThemeColors.greyAccent),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: ThemeColors.greyAccent),
    labelLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: ThemeColors.greyAccent),
    labelSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
  ),
);
