import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  MovieBottomNavigationBar(this.navigationShell, {super.key});

  // int _currentIndex(BuildContext context) {
  //   final String location = GoRouterState.of(context).matchedLocation;
  //   if (location == '/') {
  //     return 0;
  //   } else if (location == '/categories') {
  //     return 1;
  //   } else if (location == '/favorites') {
  //     return 2;
  //   }
  //   return 0;
  // }

  // void onTappedItem(BuildContext context, int value) {
  //   if (value == 0) {
  //     context.go('/');
  //   } else if (value == 1) {
  //     context.go('/categories');
  //   } else if (value == 2) {
  //     context.go('/favorites');
  //   }
  // }

  void _onTap(index) => navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: navigationShell.currentIndex, // _currentIndex(context),
      onTap: _onTap, // (value) => onTappedItem(context, value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
          activeIcon: Icon(Icons.home_rounded)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categorías',
          activeIcon: Icon(Icons.category_rounded)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
          activeIcon: Icon(Icons.favorite_rounded),
        ),
      ],
    );
  }
}