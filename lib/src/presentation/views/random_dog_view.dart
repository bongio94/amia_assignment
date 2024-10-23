import 'package:amia_assignment/src/data/repository.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:amia_assignment/src/presentation/widgets/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetRandomDog extends ConsumerStatefulWidget {
  final Object? arguments;

  const GetRandomDog({this.arguments, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetDogPageState();
}

class _GetDogPageState extends ConsumerState<GetRandomDog> {
  late final ScrollController scrollController;

  List<String> subBreed = [];

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final scheme = Theme.of(context).colorScheme;
    final groupValue = ref.watch(groupValueProvider);
    final breeds = ref.watch(randomDogByBreedProvider);

    return Scaffold(
      floatingActionButton: FilledButton.tonal(
        onPressed: groupValue != null
            ? () => ref.refresh(subBreed.isNotEmpty
                ? randomDogBySubBreedImageProvider(subBreed)
                : randomDogImageProvider(groupValue))
            : null,
        child: const AppText.m('I want more!'),
      ),
      body: ListView(
        controller: scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.maxFinite,
              height: screenSize.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: scheme.primary,
                ),
              ),
              child: groupValue == null
                  ? const Center(
                      child: AppText.l(
                        'Select a breed!',
                        isLight: true,
                      ),
                    )
                  : DogImage(
                      groupValue: groupValue,
                      subBreed: subBreed,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: AppText.l(
              groupValue?.capitalize() ?? 'Selected breed will be displayed here!',
              isBold: groupValue != null,
              isLight: groupValue == null,
              color: groupValue == null ? scheme.onSurface : scheme.primary,
              textStyle: TextStyle(
                fontStyle: groupValue == null ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
          breeds.when(
            data: (value) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.message.keys.length,
                itemBuilder: (context, index) {
                  if (value.message[value.message.keys.toList()[index]]!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: RadioMenuButton(
                        value: value.message.keys.toList()[index],
                        groupValue: groupValue,
                        onChanged: (breed) {
                          ref.read(groupValueProvider.notifier).state = breed;
                          setState(() {
                            subBreed = [];
                          });
                          if (scrollController.hasClients &&
                              scrollController.position.extentBefore > 0) {
                            scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCirc,
                            );
                          }
                        },
                        child: AppText.m(value.message.keys.toList()[index].capitalize()),
                      ),
                    );
                  }

                  return ExpansionTile(
                    dense: true,
                    tilePadding: const EdgeInsets.only(right: 16),
                    leading: Radio(
                      value: value.message.keys.toList()[index],
                      groupValue: groupValue,
                      onChanged: (breed) {
                        ref.read(groupValueProvider.notifier).state = breed;
                        setState(() {
                          subBreed = [];
                        });
                        if (scrollController.hasClients &&
                            scrollController.position.extentBefore > 0) {
                          scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutCirc,
                          );
                        }
                      },
                    ),
                    title: AppText.m(value.message.keys.toList()[index].capitalize()),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.message[value.message.keys.toList()[index]]!.length,
                        itemBuilder: (context, innerIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: RadioMenuButton(
                              value: value.message[value.message.keys.toList()[index]]![innerIndex],
                              groupValue: groupValue,
                              onChanged: (breed) {
                                ref.read(groupValueProvider.notifier).state = breed;
                                setState(() {
                                  subBreed = [
                                    value.message.keys.toList()[index],
                                    value.message[value.message.keys.toList()[index]]![innerIndex]
                                  ];
                                });
                                if (scrollController.hasClients &&
                                    scrollController.position.extentBefore > 0) {
                                  scrollController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutCirc,
                                  );
                                }
                              },
                              child: AppText.m(
                                value.message[value.message.keys.toList()[index]]![innerIndex]
                                    .capitalize(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            error: (error, stack) => Text('Error: $error'),
            loading: () => const Center(child: CircularProgressIndicator.adaptive()),
          ),
        ],
      ),
    );
  }
}

final groupValueProvider = StateProvider.autoDispose<String?>((ref) {
  return null;
});

class DogImage extends ConsumerWidget {
  final String groupValue;
  final List<String> subBreed;
  const DogImage({
    required this.groupValue,
    this.subBreed = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dynamic imageByBreed = ref.watch(subBreed.isNotEmpty
        ? randomDogBySubBreedImageProvider(subBreed)
        : randomDogImageProvider(groupValue));

    return switch (imageByBreed) {
      AsyncData(:final value) => ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: AppImage(image: value.message),
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
    };
  }
}
