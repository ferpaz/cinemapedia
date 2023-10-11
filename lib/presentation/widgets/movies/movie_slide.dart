import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemafan/config/domain/entities/movie.dart';
import 'package:cinemafan/config/helpers/human_formats.dart';

class MovieSlide extends StatelessWidget {
  final Movie movie;
  final bool showTitle;

  MovieSlide({
    required this.movie,
    this.showTitle = true
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

          if (showTitle)
          const SizedBox(height: 5),

          if (showTitle)
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
                Text('${HumanFormats.formatNumber(movie.voteAverage)}',style: styles.bodySmall),
                const Spacer(),
                Icon(Icons.thumb_up_rounded, size: 15, color: Colors.red.shade300),
                const SizedBox(width: 3),
                Text('${HumanFormats.formatCompactNumber(movie.popularity)}', style: styles.bodySmall),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
