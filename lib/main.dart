import 'package:flutter/material.dart';
import 'package:flutter_market_app/screens/navigation/navigation_screen.dart';
import 'package:flutter_market_app/themes/my_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Market App',
      theme: myTheme,
      home: const NavigationScreen(),
    );
  }
}
