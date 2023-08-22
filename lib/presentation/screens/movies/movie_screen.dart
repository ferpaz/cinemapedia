import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
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
    ref.read(actorProvider.notifier).loadActor(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialMovieScreenLoadingProvider);

    final movie = ref.watch(movieDetailsProvider)[widget.movieId];

    if (initialLoading || movie == null) {
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
                loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                    ? FadeIn(child: child)
                    : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MovieOverview(movie: movie),

        _MovieGenres(movie: movie),

        _MovieActorsList(movieId: movie.id),
      ]
    );
  }
}

class _MovieOverview extends StatelessWidget {
  const _MovieOverview({
    required this.movie
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Padding(
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

                      if (movie.releaseDate != null)
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Text('Est. ${HumanFormats.formatDate(movie.releaseDate!)}', style: styles.bodySmall?.copyWith(color: colors.tertiary)),
                          ],
                        ),

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
      );
  }
}

class _MovieGenres extends StatelessWidget {
  const _MovieGenres({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
   final styles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          ...movie.genreIds.map((g) => Container(
            margin: const EdgeInsets.only(right: 5),
            child: Chip(
              padding: const EdgeInsets.all(0),
              label: Text(g, style: styles.labelSmall,),
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20), ),
            ),
          )).toList()
        ],
      ),
    );
  }
}


class _MovieActorsList extends ConsumerStatefulWidget {
  final String movieId;
  const _MovieActorsList({required this.movieId});

  @override
  _MovieActorsListState createState() => _MovieActorsListState();
}

class _MovieActorsListState extends ConsumerState<_MovieActorsList> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    final actors = ref.watch(actorProvider)[widget.movieId];

    if (actors == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Actores', style: styles.titleMedium),

          SizedBox(
            height: 300,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: actors.length,
              itemBuilder: (context, index) {
                final actor = actors[index];

                return Container(
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 180,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              actor.profilePath,
                              fit: BoxFit.cover,
                              width: 120,
                              loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                                ? FadeIn(child: child)
                                : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                            ),
                          )
                        ),

                        SizedBox(height: 5),

                        Text(actor.name, style: styles.labelLarge!.copyWith(fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis,),
                        Text(actor.character ?? '', style: styles.labelSmall, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      ],

                    ),
                  ),
                );

              }
            ),
          ),

        ],
      ),
    );
  }
}