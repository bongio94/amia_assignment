import 'package:amia_assignment/src/presentation/views/favs_view.dart';
import 'package:amia_assignment/src/presentation/views/get_dog_view.dart';
import 'package:amia_assignment/src/presentation/views/home_view.dart';
import 'package:amia_assignment/src/presentation/views/navigation_wrapper_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey = GlobalKey<NavigatorState>();
  static final _favsNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, navigationShell) {
          return NavigationWrapperView(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeView(),
                ),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _homeNavigatorKey,
                    name: 'get_dog',
                    path: 'get_dog',
                    pageBuilder: (context, state) => MaterialPage(
                      child: GetDogPage(arguments: state.extra),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _favsNavigatorKey,
            routes: [
              GoRoute(
                path: '/favs',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: FavouriteView(),
                ),
                routes: const [],
              ),
            ],
          ),
        ],
      )
    ],
  );
}
