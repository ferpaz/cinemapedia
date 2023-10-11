import 'package:cinemafan/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemafan/presentation/providers/providers.dart';

class MoviesByCategoryView extends ConsumerStatefulWidget {
  static String routeName = 'movies-by-category-view';

  final String categoryId;
  const MoviesByCategoryView({
    super.key,
    required this.categoryId
  });

  @override
  _MoviesByCategoryViewState createState() => _MoviesByCategoryViewState();
}

class _MoviesByCategoryViewState extends ConsumerState<MoviesByCategoryView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    ref.read(genreProvider.notifier).loadGenres();
    ref.read(moviesByGenreProvider.notifier).loadNextPage(int.parse(widget.categoryId));

    _scrollController.addListener(() {
      if ((_scrollController.position.pixels + 200) > _scrollController.position.maxScrollExtent) {
        ref.read(moviesByGenreProvider.notifier).loadNextPage(int.parse(widget.categoryId));
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
    var genres = ref.watch(genreProvider);
    var moviesByGenre = ref.watch(moviesByGenreProvider)[int.parse(widget.categoryId)];

    if (genres.isEmpty || moviesByGenre == null || moviesByGenre.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    var genre = genres.firstWhere((element) => element.id.toString() == widget.categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(genre.name),
      ),
      body: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: moviesByGenre.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: MovieSearchSlide(
            movie: moviesByGenre[index],
            colors: Theme.of(context).colorScheme,
            styles: Theme.of(context).textTheme,
            size: MediaQuery.of(context).size,
            showResults: true,
          ),
        ),
      ),
    );
  }
}