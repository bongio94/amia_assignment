import 'package:amia_assignment/src/data/hive_db.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:amia_assignment/src/presentation/widgets/dog_details/breed_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteView extends ConsumerStatefulWidget {
  const FavouriteView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends ConsumerState<FavouriteView> {
  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);

    if (favorites.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            AppText.xl('No favorites yet', isLight: true),
            SizedBox(height: 8),
            AppText.m('Add some breeds to your favorites!', isLight: true),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final breed = favorites.keys.toList()[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BreedTile(
            breed: favorites.keys.toList()[index],
            subBreeds: favorites[breed] ?? 0,
          ),
        );
      },
    );
  }
}
