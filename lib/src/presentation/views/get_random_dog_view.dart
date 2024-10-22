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
        onPressed:
            groupValue != null ? () => ref.refresh(randomDogImageProvider(groupValue)) : null,
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
                      child: AppText.l('Select a breed!'),
                    )
                  : DogImage(groupValue),
            ),
          ),
          breeds.when(
            data: (value) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.message.keys.length,
                itemBuilder: (context, index) {
                  return RadioListTile.adaptive(
                    title: AppText.m(value.message.keys.toList()[index].capitalize()),
                    value: value.message.keys.toList()[index],
                    groupValue: groupValue,
                    tileColor: scheme.surface,
                    onChanged: (breed) {
                      ref.read(groupValueProvider.notifier).state = breed;
                      if (scrollController.hasClients &&
                          scrollController.position.extentBefore > 0) {
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOutCirc,
                        );
                      }
                    },
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
  const DogImage(this.groupValue, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageByBreed = ref.watch(randomDogImageProvider(groupValue));

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
