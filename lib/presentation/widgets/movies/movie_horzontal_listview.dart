import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  MovieHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListView> createState() => _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 200 <= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle,),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final movie = widget.movies[index];

                return FadeInRight(child: _Slide(movie: movie));
              }),
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  _Slide({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final styles = Theme.of(context).textTheme;

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: DecoratedBox(
              decoration: decoration,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                    ? GestureDetector(
                        child: FadeIn(child: child),
                        onTap: () => context.push('/movie/${movie.id}')
                      )
                    : SizedBox(height: 225, child: Center(child: CircularProgressIndicator(color: colors.primary, backgroundColor: colors.background,))),
                ),
              ),
            )
          ),

          const SizedBox(height: 5),

          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: styles.titleSmall,
              ),
            ),
          ),

          const SizedBox(height: 5),

          SizedBox(
            width: 150,
            child: Row(
              children: [
                const SizedBox(width: 5),
                Icon(Icons.star_half_outlined, size: 15, color: Colors.amber.shade600),
                const SizedBox(width: 3),
                Text('${HumanFormats.formatNumber(movie.voteAverage)}',style: styles.bodyMedium?.copyWith(color: colors.tertiary)),
                const Spacer(),
                Icon(Icons.favorite_rounded, size: 15, color: Colors.red.shade300),
                const SizedBox(width: 3),
                Text('${HumanFormats.formatCompactNumber(movie.popularity)}', style: styles.bodySmall?.copyWith(color: colors.tertiary)),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ]
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text( title!, style: styles.titleLarge ),

          const Spacer(),

          if (subtitle != null)
            FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text( subtitle!, style: styles.titleSmall )
            ),
      ]),
    );
  }
}