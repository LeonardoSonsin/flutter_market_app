import 'package:flutter/material.dart';
import 'package:flutter_market_app/screens/home/home_screen.dart';
import 'package:flutter_market_app/screens/order/order_screen.dart';
import 'package:flutter_market_app/screens/settings/settings_screen.dart';
import 'package:flutter_market_app/themes/theme_colors.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrderScreen(),
    const SettingsScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: ThemeColors.greenColor,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: "Home"),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? const Icon(Icons.list_alt)
                  : const Icon(Icons.list_alt_outlined),
              label: "Basket"),
          BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? const Icon(Icons.settings)
                  : const Icon(Icons.settings_outlined),
              label: "Favorites"),
        ],
      ),
    );
  }
}
