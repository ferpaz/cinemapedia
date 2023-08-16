import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const routeName = 'movie-screen';

  final String movieId;

  MovieScreen({ required this.movieId });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieDetailsProvider.notifier).loadMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieDetailsProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Scaffold(
          body: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return Scaffold(
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            _MovieDetailsSliverAppBar(movie: movie),
            SliverList(delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieInfo(movie: movie),
              childCount: 1,
              ),
            ),
          ],
        ));
  }
}

class _MovieDetailsSliverAppBar extends StatelessWidget {

  final Movie movie;

  const _MovieDetailsSliverAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final styleTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Colors.black87, Colors.transparent],
                    stops: [0, 0.18],
                  ),
                ),
              ),
            )

          ],
        )
      ),
    );
  }
}

class _MovieInfo extends StatelessWidget {
  final Movie movie;

  const _MovieInfo({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final styles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        movie.posterPath,
                        width: size.width * 0.25,
                      ),
                    ),

                    const SizedBox(height: 5),

                    SizedBox(
                      width: size.width * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 3),
                              Icon(Icons.star_half_outlined, size: 15, color: colors.tertiary),
                              const SizedBox(width: 3),
                              Text('${HumanFormats.formatNumber(movie.voteAverage)}',style: styles.bodyMedium?.copyWith(color: colors.tertiary)),
                              const Spacer(),
                              Icon(Icons.favorite_outline, size: 15, color: colors.tertiary),
                              const SizedBox(width: 3),
                              Text('${HumanFormats.formatCompactNumber(movie.popularity)}', style: styles.bodySmall?.copyWith(color: colors.tertiary)),
                              const SizedBox(width: 3),
                            ],
                          ),

                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Text('Est. ${HumanFormats.formatDate(movie.releaseDate)}', style: styles.bodySmall?.copyWith(color: colors.tertiary)),
                            ],
                          ),

                          // Row(
                          //   children: [
                          //     const SizedBox(width: 5),
                          //     Text('${HumanFormats.formatNumber(movie.)}', style: styles.bodySmall?.copyWith(color: colors.tertiary)),
                          //   ],
                          // ),

                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 8),

                SizedBox(
                  width: (size.width) * 0.7 - 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title, style: styles.titleLarge),
                        const SizedBox(height: 5),
                        Text(movie.overview, style: styles.bodyMedium),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),

          const SizedBox(height: 20),

      ]
    );
  }
}