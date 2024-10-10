import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppImage extends ConsumerWidget {
  const AppImage({required this.image, super.key});

  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Image.network(
      image,
      fit: BoxFit.cover,
      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          child: child,
        );
      },
    );
  }
}
