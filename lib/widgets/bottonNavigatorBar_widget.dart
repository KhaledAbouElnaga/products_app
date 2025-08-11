import 'package:beggining/factory/color_factory.dart';
import 'package:beggining/screens/favorite_sc.dart';
import 'package:beggining/screens/products_sc.dart';
import 'package:flutter/material.dart';

class BottonnavigatorbarWidget extends StatefulWidget {
  const BottonnavigatorbarWidget({super.key});

  @override
  State<BottonnavigatorbarWidget> createState() =>
      _BottonnavigatorbarWidgetState();
}

class _BottonnavigatorbarWidgetState extends State<BottonnavigatorbarWidget> {
  int tap = 0;
  final List<Widget> pages = [ProductsSc(), FavoriteSc()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[tap],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tap,
        onTap: (value) {
          setState(() {
            tap = value;
          });
        },
        selectedItemColor: ColorFactory.primary,
        unselectedItemColor: ColorFactory.textSecondary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          )
        ],
      ),
    );
  }
}
