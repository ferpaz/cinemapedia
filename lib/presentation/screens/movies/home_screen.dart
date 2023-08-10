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

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es-US', null);

    final colors = Theme.of(context).colorScheme;

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    if (slideShowMovies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return CustomScrollView(slivers: [
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
                title: 'En cines',
                subtitle: '${DateFormat('EEEEE', 'es-US').format(DateTime.now())} ${DateTime.now().day}',
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),

              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'Populares',
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'Mejor calificados',
                subtitle: 'En este mes',
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              const SizedBox(height: 10),
            ]);
          },
          childCount: 1,
        ),
      ),
    ]);
  }
}
