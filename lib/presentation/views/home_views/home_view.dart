import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:cinemafan/presentation/delegates/movie_search_delegate.dart';
import 'package:cinemafan/presentation/providers/providers.dart';
import 'package:cinemafan/presentation/widgets/widgets.dart';


class HomeView extends ConsumerStatefulWidget {
  static const routeName = 'home-view';

  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    // Inicializa los proveedores de películas de las diferentes categorías
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();

    ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery(query: '');
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es-US', null);

    final initialLoading = ref.watch(initialHomeScreenLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    FlutterNativeSplash.remove();

    final colors = Theme.of(context).colorScheme;

    // Inicializa la lista de películas en el Slide Show de Peliculas
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    // Inicializa la lista de películas en la diferentes categorías
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    final searchQuery = ref.watch(searchQueryProvider);
    final searchedMovies = ref.watch(searchedMoviesProvider);

    final isDarkMode = ref.watch(darkModeProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          leading: Icon(Icons.movie_outlined, color: colors.primary),
          title: Text('Cinema Fan'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  query: searchQuery,
                  context: context,
                  delegate: MovieSearchDelegate(
                    initialMovies: searchedMovies,
                    searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery,

                  )
                );
              },
              icon: Icon(Icons.search, color: colors.primary),

            ),

            IconButton(
              onPressed: () {
                ref.read(darkModeProvider.notifier).toggleDarkMode();
              },
              icon: Icon(
                isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: colors.primary,
              ),
            ),
          ],

        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(children: [
                  MovieSlideShow(movies: slideShowMovies),

                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'En cartelera',
                    subtitle: '${DateFormat('EEEEE', 'es-US').format(DateTime.now())} ${DateTime.now().day}',
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: upcomingMovies,
                    title: 'Próximamente en cines',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),

                  const SizedBox(height: 10),
                ]),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
