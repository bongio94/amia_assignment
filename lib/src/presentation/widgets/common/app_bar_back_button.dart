import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdaptiveAppBarBackButton extends ConsumerWidget {
  const AdaptiveAppBarBackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = Theme.of(context).platform;

    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: Icon(platform == TargetPlatform.android
          ? Icons.arrow_back_rounded
          : Icons.arrow_back_ios_new_rounded),
    );
  }
}
