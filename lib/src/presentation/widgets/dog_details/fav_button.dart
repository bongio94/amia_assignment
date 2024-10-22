import 'package:amia_assignment/src/data/hive_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavButton extends ConsumerWidget {
  final String selectedBreed;
  final int subBreeds;
  const FavButton({
    required this.selectedBreed,
    required this.subBreeds,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(favoritesProvider.select((favorites) => favorites.containsKey(selectedBreed)));
    final notifier = ref.read(favoritesProvider.notifier);

    return IconButton(
      onPressed: () async {
        notifier.toggleFavorite(selectedBreed, subBreeds);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          color: isFavorite ? Colors.red : null,
          key: ValueKey<bool>(isFavorite),
        ),
      ),
    );
  }
}
