import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetACard extends ConsumerStatefulWidget {
  const GetACard({
    required this.label,
    this.onTap,
    super.key,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetACardState();
}

class _GetACardState extends ConsumerState<GetACard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: InkWell(
        onHover: (isHovered) {

        },
        splashFactory: InkSparkle.splashFactory,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText.s(widget.label),
        ),
      ),
    );
  }
}
