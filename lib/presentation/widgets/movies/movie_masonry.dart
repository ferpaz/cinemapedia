import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cinemafan/config/domain/entities/movie.dart';
import 'package:cinemafan/presentation/widgets/widgets.dart';

class MovieMasonery extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  MovieMasonery({
    super.key,
    required this.movies,
    this.loadNextPage
  });

  @override
  State<MovieMasonery> createState() => _MovieMasoneryState();
}

class _MovieMasoneryState extends State<MovieMasonery> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((_scrollController.position.pixels + 100) >= _scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: _scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if ( index == 1 )
          {
            return Column(
              children: [
                const SizedBox(height: 40),
                MoviePosterLink(movie: widget.movies[index],),
              ],
            );
          }

          return MoviePosterLink(movie: widget.movies[index],);
        },
      ),
    );
  }
}
