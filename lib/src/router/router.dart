import 'package:amia_assignment/src/presentation/views/favs_view.dart';
import 'package:amia_assignment/src/presentation/views/get_random_dog_by_breed_view.dart';
import 'package:amia_assignment/src/presentation/views/get_random_dog_view.dart';
import 'package:amia_assignment/src/presentation/views/home_view.dart';
import 'package:amia_assignment/src/presentation/views/navigation_wrapper_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _favsNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/${AppRoutes.home.routeName}',
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
              name: AppRoutes.home.routeName,
              path: '/${AppRoutes.home.routeName}',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeView(),
              ),
              routes: [
                GoRoute(
                  name: AppRoutes.getRandomDog.routeName,
                  path: '/${AppRoutes.getRandomDog.routeName}',
                  pageBuilder: (context, state) => MaterialPage(
                    child: GetRandomDog(arguments: state.extra),
                  ),
                ),
                GoRoute(
                  name: AppRoutes.getRandomDogByBreed.routeName,
                  path: '/${AppRoutes.getRandomDogByBreed.routeName}',
                  pageBuilder: (context, state) => const MaterialPage(
                    child: GetRandomDogByBreedView(),
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
              name: AppRoutes.favs.routeName,
              path: '/${AppRoutes.favs.routeName}',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FavouriteView(),
              ),
            ),
          ],
        ),
      ],
    )
  ],
);

enum AppRoutes {
  home('home'),
  favs('favs'),
  getRandomDog('getRandomDog'),
  getRandomDogByBreed('getRandomDogByBreed');

  const AppRoutes(this.routeName);
  final String routeName;
}
