import 'package:amia_assignment/src/data/repository.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:amia_assignment/src/presentation/views/breed_detail_view.dart';
import 'package:amia_assignment/src/presentation/widgets/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BreedTile extends ConsumerStatefulWidget {
  const BreedTile({
    required this.breed,
    this.subBreeds = 0,
    this.subBreed,
    super.key,
  });

  final String breed;
  final int subBreeds;
  final String? subBreed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BreedCardState();
}

class _BreedCardState extends ConsumerState<BreedTile> {
  @override
  Widget build(BuildContext context) {
    final breedPicture = ref.watch(breedPictureProvider(widget.breed));

    final size = MediaQuery.sizeOf(context);
    final scheme = Theme.of(context).colorScheme;

    return switch (breedPicture) {
      AsyncData(:final value) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ListTileTheme(
            contentPadding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ListTile(
              tileColor: scheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onTap: () {
                ref.read(currentBreedProvider.notifier).state = widget.breed;
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return BreedDetailsView(
                        images: value.message,
                        breed: widget.breed.capitalize(),
                      );
                    });
              },
              title: AppText.l(
                widget.breed.capitalize(),
                isBold: true,
                color: scheme.onSurface,
              ),
              subtitle: AppText.m(
                '${widget.subBreeds} ${widget.subBreeds == 1 ? 'sub-breed' : 'sub-breeds'} found',
                color: scheme.onSurface,
                isLight: true,
              ),
              leading: Container(
                width: size.width * 0.2,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: AppImage(image: value.message.first),
              ),
            ),
          ),
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}

final currentBreedProvider = StateProvider<String>((ref) {
  return '';
});

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
