import 'package:amia_assignment/src/data/repository.dart';
import 'package:amia_assignment/src/presentation/widgets/dog_details/breed_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetRandomDogByBreedView extends ConsumerStatefulWidget {
  const GetRandomDogByBreedView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetRandomDogByBreedViewState();
}

class _GetRandomDogByBreedViewState extends ConsumerState<GetRandomDogByBreedView> {
  @override
  Widget build(BuildContext context) {
    final breeds = ref.watch(randomDogByBreedProvider);

    return Scaffold(
      body: switch (breeds) {
        AsyncData(:final value) => ListView.builder(
            shrinkWrap: true,
            itemCount: value.message.keys.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BreedTile(
                  breed: value.message.keys.toList()[index],
                  subBreeds: value.message[value.message.keys.toList()[index]]!.length,
                ),
              );
            },
          ),
        AsyncError(:final error) => Text('Error: $error'),
        _ => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
      },
    );
  }
}

final breedProvider = StateProvider<String>((ref) {
  return '';
});
