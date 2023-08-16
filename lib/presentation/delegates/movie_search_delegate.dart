import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function({int page, required String query});

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController<List<Movie>>.broadcast();
  Timer? _debounceTimer;

  MovieSearchDelegate(this.searchMovies);

  void _onQueryChange(String query) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }

      final movies = await searchMovies(query: query);
      debouncedMovies.add(movies);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) => [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: () => query = '',
          icon: Icon(Icons.clear)
        ),
      ),
    ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back)
      );

  @override
  Widget buildResults(BuildContext context) => StreamBuilder<List<Movie>>(
      stream: debouncedMovies.stream,
      initialData: [],
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => ListTile(
            title: _MovieTitleSuggestion(movies[index]),
          ),
        );
      },
    );

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);

    return StreamBuilder<List<Movie>>(
      stream: debouncedMovies.stream,
      initialData: [],
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => ListTile(
            title: _MovieTitleSuggestion(movies[index]),
          ),
        );
      },
    );
  }
}

class _MovieTitleSuggestion extends StatelessWidget {
  final Movie movie;

  _MovieTitleSuggestion(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    final styles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                    ? FadeIn(child: child)
                    : Center(child: CircularProgressIndicator()),
                )
              ),
            ),

            const SizedBox(width: 10),


            SizedBox(
              width: size.width * 0.68,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: styles.bodyMedium,),
                  const SizedBox(height: 3),
                  Text(movie.overview, maxLines: 3, overflow: TextOverflow.ellipsis, style: styles.labelSmall,),
                  const SizedBox(height: 3),
                  // generar tantas estrellas de acuerdo a movie.voteAverage
                  Row(
                    children: [
                      Icon(Icons.star_half_outlined, size: 15, color: Colors.amber.shade600),
                      const SizedBox(width: 3),
                      Text(HumanFormats.formatNumber(movie.voteAverage), style: styles.labelSmall!.copyWith(color: colors.tertiary)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}