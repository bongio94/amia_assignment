import 'package:amia_assignment/src/data/repository.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:amia_assignment/src/presentation/widgets/dog_details/images_carousel.dart';
import 'package:amia_assignment/src/presentation/widgets/dog_details/sub_breed_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BreedDetailsView extends ConsumerStatefulWidget {
  const BreedDetailsView({
    required this.images,
    required this.breed,
    this.subBreeds = const [],
    super.key,
  });

  final List<String> images;
  final String breed;
  final List<String> subBreeds;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BreedDetailsViewState();
}

class _BreedDetailsViewState extends ConsumerState<BreedDetailsView> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    final subBreeds = ref.watch(subBreedProvider(widget.breed));

    return BottomSheet(
      onClosing: () {},
      animationController: BottomSheet.createAnimationController(this),
      builder: (context) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: CustomScrollView(
            slivers: [
              SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.xl(
                          widget.breed,
                          isBold: true,
                        ),
                        IconButton.filledTonal(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.close_rounded),
                        )
                      ],
                    ),
                  ),
                  DogImagesCarousel(images: widget.images),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: AppText.l(
                      'Sub-Breeds',
                      isBold: true,
                    ),
                  ),
                  subBreeds.when(
                    data: (data) {
                      if (data.message.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: AppText.m(
                            'No sub breeds',
                            isLight: true,
                          ),
                        );
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: data.message.map((subBreed) {
                          return SubBreedCardStateless(breed: widget.breed, subBreed: subBreed);
                        }).toList(),
                      );
                    },
                    error: (error, stackTrace) {
                      return Text('Error: $error');
                    },
                    loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
