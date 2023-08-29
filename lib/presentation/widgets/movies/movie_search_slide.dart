import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';

class MovieSearchSlide extends StatelessWidget {
  const MovieSearchSlide({
    super.key,
    required this.movie,
    required this.showResults,
    required this.size,
    required this.styles,
    required this.colors,
  });

  final Movie movie;
  final bool showResults;
  final Size size;
  final TextTheme styles;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                    ? showResults ? child : FadeIn(child: child)
                    : Center(child: CircularProgressIndicator()),
                )
              ),
            ),

            const SizedBox(width: 10),


            SizedBox(
              width: size.width * 0.68,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: styles.bodyMedium,),
                  const SizedBox(height: 3),
                  Text(movie.overview, maxLines: 3, overflow: TextOverflow.ellipsis, style: styles.labelSmall,),
                  const SizedBox(height: 3),
                  // generar tantas estrellas de acuerdo a movie.voteAverage
                  Row(
                    children: [
                      Icon(Icons.star_half_outlined, size: 15, color: Colors.amber.shade600),
                      const SizedBox(width: 3),
                      Text(HumanFormats.formatNumber(movie.voteAverage), style: styles.labelSmall!.copyWith(color: colors.tertiary)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}