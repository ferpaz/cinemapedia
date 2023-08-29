import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  MovieBottomNavigationBar(this.navigationShell, {super.key});

  void _onTap(index) => navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: Theme.of(context).iconTheme.copyWith(color: Theme.of(context).colorScheme.primary),
      selectedItemColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      currentIndex: navigationShell.currentIndex, // _currentIndex(context),
      onTap: _onTap, // (value) => onTappedItem(context, value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
          activeIcon: Icon(Icons.home_rounded),
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