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
  @override
  Widget build(BuildContext context) {
    final dogData = ref.watch(randomDogImageProvider);

    return Scaffold(
      floatingActionButton: FilledButton.tonal(
          onPressed: () => ref.refresh(randomDogImageProvider),
          child: const AppText.m('I want more!')),
      body: switch (dogData) {
        AsyncData(:final value) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(32),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AppImage(image: value.message),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        AsyncError(:final error) => Text('Error: $error'),
        _ => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
      },
    );
  }
}
