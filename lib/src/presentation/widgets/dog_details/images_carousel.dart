import 'dart:ui';

import 'package:amia_assignment/src/presentation/widgets/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kCarouselAnimationDurationInMs = 200;

class DogImagesCarousel extends ConsumerStatefulWidget {
  const DogImagesCarousel({
    required this.images,
    this.padding,
    super.key,
  });

  final List<String> images;
  final double? padding;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DogImagesCarouselState();
}

class _DogImagesCarouselState extends ConsumerState<DogImagesCarousel> {
  late final CarouselController carouselController;

  FlutterView view = PlatformDispatcher.instance.views.first;
  late final double physicalWidth;
  late final double screenWidth;

  int currentCarouselIndex = 0;

  @override
  void initState() {
    carouselController = CarouselController();
    physicalWidth = view.physicalSize.width;
    screenWidth = physicalWidth / view.devicePixelRatio;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      carouselController.position.isScrollingNotifier.addListener(() {
        if (!carouselController.position.isScrollingNotifier.value) {
          setState(() {
            currentCarouselIndex = (carouselController.offset / screenWidth).ceil();
          });
        }
      });
    });
    super.initState();
  }

  int currentItem = 0;
  bool scrollEnded = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final carouselItemExtent = size.width - (widget.padding ?? 0);

    return SizedBox(
      height: size.height * 0.4,
      child: Stack(
        children: [
          CarouselView(
            controller: carouselController,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            itemExtent: carouselItemExtent,
            itemSnapping: true,
            children: widget.images
                .map(
                  (image) => AppImage(image: image),
                )
                .toList(),
          ),
          if (widget.images.length > 1)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () {
                        if (currentCarouselIndex > 0) {
                          setState(() {
                            currentCarouselIndex--;
                          });
                        }
                        carouselController.animateTo(carouselItemExtent * currentCarouselIndex,
                            duration: const Duration(milliseconds: _kCarouselAnimationDurationInMs), curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.chevron_left),
                    ),
                    IconButton.filledTonal(
                      onPressed: () {
                        setState(() {
                          currentCarouselIndex++;
                        });

                        carouselController.animateTo(carouselItemExtent * currentCarouselIndex,
                            duration: const Duration(milliseconds: _kCarouselAnimationDurationInMs), curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.chevron_right),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
