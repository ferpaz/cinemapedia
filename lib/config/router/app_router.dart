import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',

  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (_, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: MovieBottomNavigationBar(navigationShell),
        );
      },

      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              name: HomeView.routeName,
              builder: (_, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.routeName,
                  builder: (_, state) {
                    final id = state.pathParameters['id'] ?? "Unknow Id";
                    return MovieScreen(movieId: id);
                  }
                ),
              ]
            ),
          ]
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/categories',
              name: CategoriesView.routeName,
              builder: (_, state) => const CategoriesView(),
            ),
          ]
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/favorites',
              name: FavoritesView.routeName,
              builder: (_, state) => const FavoritesView(),
            ),
          ]
        ),

      ]
    ),

  ]
);