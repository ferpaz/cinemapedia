import 'package:cinemapedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: MovieBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    // Inicializa los proveedores de películas de las diferentes categorías
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es-US', null);

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final colors = Theme.of(context).colorScheme;

    // Inicializa la lista de películas en el Slide Show de Peliculas
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    // Inicializa la lista de películas en la diferentes categorías
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          leading: Icon(Icons.movie_outlined, color: colors.primary),
          title: Text('Cinemapedia'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: colors.primary),
            ),
          ],

        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(children: [
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
              ]);
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
