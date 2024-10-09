import 'package:amia_assignment/src/data/repository.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BreedCard extends ConsumerStatefulWidget {
  const BreedCard({
    required this.breed,
    this.subBreeds = 0,
    super.key,
  });

  final String breed;
  final int subBreeds;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BreedCardState();
}

class _BreedCardState extends ConsumerState<BreedCard> {
  @override
  Widget build(BuildContext context) {
    final breedPicture = ref.watch(breedPictureProvider(widget.breed));
    final size = MediaQuery.sizeOf(context);
    final scheme = Theme.of(context).colorScheme;

    return switch (breedPicture) {
      AsyncData(:final value) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ListTileTheme(
            contentPadding: const EdgeInsets.only(left: 8.0),
            child: ExpansionTile(
              collapsedBackgroundColor: scheme.surfaceContainer,
              backgroundColor: scheme.primaryContainer,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              title: AppText.l(
                widget.breed.capitalize(),
                isBold: true,
                color: scheme.onSurface,
              ),
              subtitle: AppText.m(
                '${widget.subBreeds} sub breeds found',
                color: scheme.onSurface,
                isLight: true,
              ),
              leading: Container(
                width: size.width * 0.2,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  value.message.first,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      /* Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: scheme.surfaceContainerLow,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size.width * 0.2,
                height: size.height * 0.1,
                margin: const EdgeInsets.all(8.0),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  value.message.first,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.m(
                        widget.breed.capitalize(),
                        isBold: true,
                        color: scheme.onSurface,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      AppText.m(
                        '${widget.subBreeds} sub breeds found',
                        color: scheme.onSurface,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ), */
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
