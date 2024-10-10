import 'package:amia_assignment/src/presentation/widgets/common/get_a_card.dart';
import 'package:amia_assignment/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 16 / 9,
        children: [
          GetACard(
            label: 'Get a random Dog',
            onTap: () {
              context.pushNamed(AppRoutes.getRandomDog.routeName, extra: RequestType.randomDog);
            },
          ),
          GetACard(
            label: 'Get a random Dog by breed',
            onTap: () {
              context.pushNamed(AppRoutes.getAllBreeds.routeName, extra: RequestType.randomDogByBreed);
            },
          ),
        ],
      ),
    );
  }
}

enum RequestType {
  randomDog,
  randomDogByBreed,
}
