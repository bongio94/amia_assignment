import 'package:amia_assignment/src/data/repository.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:amia_assignment/src/presentation/widgets/common/app_image.dart';
import 'package:amia_assignment/src/presentation/widgets/dog_details/images_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubBreedCard extends ConsumerWidget {
  final String breed;
  final String subBreed;

  SubBreedCard({
    required this.breed,
    required this.subBreed,
    super.key,
  });

  final GlobalKey expansionTileKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subBreedImage = ref.watch(subBreedRandomImageProvider(subBreed));
    final subBreedImages = ref.watch(subBreedImagesProvider(subBreed));
    final size = MediaQuery.sizeOf(context);

    return switch (subBreedImage) {
      AsyncData(:final value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            key: expansionTileKey,
            childrenPadding: EdgeInsets.zero,
            onExpansionChanged: (isExpanded) {
              final keyContext = expansionTileKey.currentContext;
              if (isExpanded && keyContext != null) {
                Future.delayed(const Duration(milliseconds: 300)).then((value) {
                  Scrollable.ensureVisible(
                    keyContext,
                    alignment: 1,
                    alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                });
              }
            },
            tilePadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            title: AppText.m(subBreed.capitalize()),
            subtitle: const AppText.s(
              'Tap to see more photos',
              isLight: true,
            ),
            leading: Container(
              height: size.width * 0.2,
              width: size.width * 0.2,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: AppImage(image: value.message),
            ),
            children: [
              DogImagesCarousel(
                images: subBreedImages.valueOrNull?.message ?? [],

                /// Adding the amount of padding to account for the expansion tile and not break the [DogImagesCarousel] calculations.
                padding: 16,
              ),
            ],
          ),
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
    };
  }
}
