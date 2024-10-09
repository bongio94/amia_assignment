import 'package:amia_assignment/src/presentation/theme/theme_provider.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTopNavigationBar extends ConsumerStatefulWidget {
  const AppTopNavigationBar({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppTopNavigationBarState();
}

class _AppTopNavigationBarState extends ConsumerState<AppTopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final scheme = Theme.of(context).colorScheme;

    return AppBar(
      title: AppText.xl(
        'Amia App',
        isBold: true,
        textStyle: AppTypography.defaultTextStyle.copyWith(color: scheme.onPrimary),
      ),
      actions: [
        IconButton(
          color: scheme.onPrimary,
          onPressed: () {
            ref.read(appThemeProvider.notifier).setTheme(theme.isLight ? ThemeMode.dark : ThemeMode.light);
          },
          icon: Icon(
            theme.isLight ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          ),
        ),
      ],
    );
  }
}
