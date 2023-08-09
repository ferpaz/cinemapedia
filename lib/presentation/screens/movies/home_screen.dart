import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: _HomeView(),
    ));
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
    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    if (slideShowMovies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
        children: [
          MovieAppBar(),

          MovieSlideShow(movies: slideShowMovies),

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: nowPlayingMovies.length,
          //     itemBuilder: (context, index) {
          //       final movie = nowPlayingMovies[index];

          //       return ListTile(
          //         title: Text(movie.title),
          //         subtitle: Text(movie.overview),
          //       );
          //     },
          //   ),
          // ),
        ]
      );
  }
}
