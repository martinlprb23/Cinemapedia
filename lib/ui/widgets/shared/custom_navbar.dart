import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(elevation: 0, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(Icons.label_important_outline), label: 'Categories'),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_rounded), label: 'Favorites'),
    ]);
  }
}
