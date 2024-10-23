import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetACard extends ConsumerStatefulWidget {
  const GetACard({
    required this.label,
    required this.icon,
    this.onTap,
    super.key,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData icon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetACardState();
}

class _GetACardState extends ConsumerState<GetACard> {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: InkWell(
        onHover: (isHovered) {},
        splashFactory: InkSparkle.splashFactory,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.l(widget.label),
                  const SizedBox(
                    height: 32,
                  ),
                  Icon(widget.icon, color: scheme.primary, size: 32),
                ],
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
