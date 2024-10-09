import 'package:amia_assignment/src/presentation/theme/theme_provider.dart';
import 'package:amia_assignment/src/presentation/theme/typography.dart';
import 'package:amia_assignment/src/presentation/widgets/common/app_bar_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppTopNavigationBar extends ConsumerStatefulWidget {
  const AppTopNavigationBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppTopNavigationBarState();
}

class _AppTopNavigationBarState extends ConsumerState<AppTopNavigationBar> {
  bool _showLeading(BuildContext context) {
    print(GoRouter.of(context).canPop());
    return GoRouter.of(context).canPop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final scheme = Theme.of(context).colorScheme;

    return AppBar(
      leading: _showLeading(context) ? const AdaptiveAppBarBackButton() : null,
      title: AppText.xl(
        'Amia App',
        isBold: true,
        textStyle: AppTypography.defaultTextStyle.copyWith(color: scheme.onPrimary),
      ),
      actions: [
        IconButton(
          color: scheme.onPrimary,
          onPressed: () {
            ref
                .read(appThemeProvider.notifier)
                .setTheme(theme.isLight ? ThemeMode.dark : ThemeMode.light);
          },
          icon: Icon(
            theme.isLight ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          ),
        ),
      ],
    );
  }
}
