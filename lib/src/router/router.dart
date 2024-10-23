import 'package:amia_assignment/src/presentation/views/favs_view.dart';
import 'package:amia_assignment/src/presentation/views/breed_list_view.dart';
import 'package:amia_assignment/src/presentation/views/random_dog_view.dart';
import 'package:amia_assignment/src/presentation/views/home_view.dart';
import 'package:amia_assignment/src/presentation/views/navigation_wrapper_view.dart';
import 'package:flutter/cupertino.dart';
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
              parentNavigatorKey: _homeNavigatorKey,
              name: AppRoutes.home.routeName,
              path: '/${AppRoutes.home.routeName}',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeView(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: _homeNavigatorKey,
              name: AppRoutes.getRandomDog.routeName,
              path: '/${AppRoutes.getRandomDog.routeName}',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const GetRandomDog(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: _homeNavigatorKey,
              name: AppRoutes.getAllBreeds.routeName,
              path: '/${AppRoutes.getAllBreeds.routeName}',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const GetRandomDogByBreedView(),
              ),
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

Page buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  final platform = Theme.of(context).platform;

  switch (platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.windows:
    case TargetPlatform.linux:
      return MaterialPage(key: state.pageKey, child: child);
    case TargetPlatform.macOS:
    case TargetPlatform.iOS:
      return CupertinoPage(key: state.pageKey, child: child);
  }
}

enum AppRoutes {
  home('home'),
  favs('favs'),
  getRandomDog('getRandomDog'),
  getAllBreeds('getAllBreeds');

  const AppRoutes(this.routeName);
  final String routeName;
}
