import 'package:flutter/material.dart';
import 'package:flutter_market_app/screens/cart/cart_screen.dart';
import 'package:flutter_market_app/screens/home/home_screen.dart';
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
    const CartScreen(),
    const CartScreen(),
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
                  ? const Icon(Icons.shopping_basket)
                  : const Icon(Icons.shopping_basket_outlined),
              label: "Basket"),
          BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_outline),
              label: "Favorites"),
        ],
      ),
    );
  }
}
