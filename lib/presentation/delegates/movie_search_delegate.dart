import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function({required String query});

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  List<Movie> initialMovies;

  final SearchMoviesCallback searchMovies;

  StreamController<List<Movie>> _debouncedMovies = StreamController<List<Movie>>.broadcast();
  StreamController<bool> _isLoadingStream = StreamController<bool>.broadcast();

  Timer? _debounceTimer;

  MovieSearchDelegate({
    this.initialMovies = const [],
    required this.searchMovies ,
  });


  void _onQueryChange(String query) async {
    _isLoadingStream.add(true && query.isNotEmpty);

    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      initialMovies = await searchMovies(query: query);
      _debouncedMovies.add(initialMovies);
      _isLoadingStream.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) => [
    StreamBuilder(
      initialData: false,
      stream: _isLoadingStream.stream,
      builder: (context, snapshot) {
        if (snapshot.data ?? false)
          return SpinPerfect(
            duration: const Duration(seconds: 20),
            spins: 10,
            child: IconButton(
              onPressed: () {
                query = '';
                _onQueryChange(query);
              },
              icon: Icon(Icons.refresh_rounded)
            ),
          );

        return FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: () {
              query = '';
              _onQueryChange(query);
            },
            icon: Icon(Icons.clear)
          ),
        );
      },
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, null),
    icon: Icon(Icons.arrow_back)
  );

  @override
  Widget buildResults(BuildContext context) => _buildResultsAndSuggestions(showResults: true);

  @override
  Widget buildSuggestions(BuildContext context) => _buildResultsAndSuggestions();

  Widget _buildResultsAndSuggestions({ bool showResults = false }) {
    if (!showResults) _onQueryChange(query);

    return StreamBuilder<List<Movie>>(
      stream: _debouncedMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => ListTile(
            title: _MovieTitleSuggestion(movies[index], showResults: showResults,),
          ),
        );
      },
    );
  }
}

class _MovieTitleSuggestion extends StatelessWidget {
  final Movie movie;

  final bool showResults;

  _MovieTitleSuggestion(this.movie, { this.showResults = false });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    final styles = Theme.of(context).textTheme;

    return MovieSearchSlide(movie: movie, showResults: showResults, size: size, styles: styles, colors: colors);
  }
}
