import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

class FavoritesView extends ConsumerStatefulWidget {
  static const routeName = 'favorites-view';

  const FavoritesView({super.key});

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  void loadlNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    isLastPage = movies.isEmpty;
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    loadlNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final _favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (_favoriteMovies.isEmpty)
    {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border_rounded, size: 80),
            SizedBox(height: 10),
            Text('Ohhh no!!', style: Theme.of(context).textTheme.displaySmall,),
            Text('No has agregado películas favoritas'),
          ],
        )
      );
    }

    return Scaffold(
      body: MovieMasonery(
        movies: _favoriteMovies,
        loadNextPage: loadlNextPage
      ),
    );
  }
}