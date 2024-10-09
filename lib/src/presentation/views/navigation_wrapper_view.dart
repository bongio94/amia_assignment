import 'package:amia_assignment/src/presentation/widgets/common/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationWrapperView extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationWrapperView({
    required this.navigationShell,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AmiaHomePageState();
}

class _AmiaHomePageState extends ConsumerState<NavigationWrapperView> {
  void _navigateTo(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
            label: 'Home',
            icon: Icon(
              Icons.home_rounded,
            ),
          ),
          NavigationDestination(
            label: 'Favourites',
            icon: Icon(
              Icons.favorite_rounded,
            ),
          ),
        ],
        onDestinationSelected: _navigateTo,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(58),
        child: AppTopNavigationBar(),
      ),
      body: widget.navigationShell,
    );

    /* return FutureBuilder(
      future: AmiaAppRepository.fetchRandomDogImage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return Container();
      },
    ); */
  }
}
