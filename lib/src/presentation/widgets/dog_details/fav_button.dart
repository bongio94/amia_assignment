import 'package:amia_assignment/src/data/hive_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavButton extends ConsumerWidget {
  final String selectedBreed;
  const FavButton({required this.selectedBreed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final notifier = ref.read(favoritesProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: () async {
        notifier.toggleFavorite(selectedBreed);
      },
      icon: Icon(
        favorites.contains(selectedBreed) ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
      ),
    );
  }
}
