import 'package:flutter/material.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final styles = Theme.of(context).textTheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.movie_outlined, color: colors.primary),
            SizedBox(width: 5),
            Text('Cinemapedia', style: styles.titleLarge),
            Spacer(),
            IconButton(
              icon: Icon(Icons.search_outlined, color: colors.primary),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
