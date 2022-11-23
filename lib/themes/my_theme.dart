import 'package:flutter/material.dart';
import 'package:flutter_market_app/themes/theme_colors.dart';

ThemeData myTheme = ThemeData(
  primarySwatch: ThemeColors.primaryColor,
  primaryColor: ThemeColors.primaryColor,
  brightness: Brightness.light,
  fontFamily: 'Raleway',
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16.0),
    bodyLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
  ),
);
