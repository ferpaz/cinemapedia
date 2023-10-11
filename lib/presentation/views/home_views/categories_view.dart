import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemafan/presentation/providers/providers.dart';

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

    final isDarkMode = ref.watch(darkModeProvider) == true;

    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      actions: [
          IconButton(
              onPressed: () {
                ref.read(darkModeProvider.notifier).toggleDarkMode();
              },
              icon: Icon(
                isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return ListTile(
            title: Text(genre.name),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => {
              context.push('/categories/movies/${genre.id}'),
            },
          );
        },
      )
    );
  }
}