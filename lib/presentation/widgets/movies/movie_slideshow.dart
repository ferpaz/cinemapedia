import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:cinemafan/config/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MovieSlideShow extends StatelessWidget {

  final List<Movie> movies;

  const MovieSlideShow({required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,

      child: Swiper(
        autoplay: true,
        scale: 0.85,
        viewportFraction: 0.8,

        itemCount: movies.length,
        itemBuilder: (_, int index) => _Slide(movies[index]),

        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 10),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.onBackground.withOpacity(0.5),
            size: 8,
            activeSize: 12,
          ),
        ),
      )
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide(this.movie);

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

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

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
              ? GestureDetector(
                  child: FadeIn(child: child),
                  onTap: () => context.push('/movie/${movie.id}')
                )
              : DecoratedBox(
                  decoration: decoration,
                  child: Center(child: CircularProgressIndicator(color: colors.primary, backgroundColor: colors.background,))
              ),
          ),
        ),
      ),
    );
  }
}