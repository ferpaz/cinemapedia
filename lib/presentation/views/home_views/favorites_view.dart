import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  static const routeName = 'favorites-view';

  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites View'),
      ),
      body: const Center(child: Text('Favoritos')),
    );
  }
}