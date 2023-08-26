import 'package:cinemapedia/presentation/providers/genres/genres_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerStatefulWidget {
  static const routeName = 'categories-view';

  const CategoriesView({super.key});

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {

  @override
  void initState() {
    super.initState();
    ref.read(genreProvider.notifier).loadGenres();
  }

  @override
  Widget build(BuildContext context) {
    var genres = ref.watch(genreProvider);

    if (genres.isEmpty)
    {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      body: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return ListTile(
            title: Text(genre.name),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => {},
          );
        },
      )
    );
  }
}