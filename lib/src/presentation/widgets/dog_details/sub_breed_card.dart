import 'package:amia_assignment/src/data/repository.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:amia_assignment/src/presentation/widgets/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubBreedCardStateless extends ConsumerWidget {
  final String breed;
  final String subBreed;

  const SubBreedCardStateless({
    required this.breed,
    required this.subBreed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subBreedImage = ref.watch(subBreedRandomImageProvider(subBreed));
    final size = MediaQuery.sizeOf(context);

    return switch (subBreedImage) {
      AsyncData(:final value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: AppText.m(subBreed.capitalize()),
            trailing: FilledButton.tonal(
              onPressed: () {},
              child: const AppText.s('See more'),
            ),
            leading: Container(
              width: size.width * 0.2,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: AppImage(image: value.message),
            ),
          ),
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
    };
  }
}
