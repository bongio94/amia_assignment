import 'package:amia_assignment/src/presentation/theme/app_theme_data.dart';
import 'package:amia_assignment/src/presentation/theme/theme_provider.dart';
import 'package:amia_assignment/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<Map>('favs');

  runApp(
    const ProviderScope(
      child: NavigationWrapperPage(),
    ),
  );
}

class NavigationWrapperPage extends ConsumerStatefulWidget {
  const NavigationWrapperPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AmiaAssignmentAppState();
}

class _AmiaAssignmentAppState extends ConsumerState<NavigationWrapperPage> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return MaterialApp.router(
      title: 'Dog Collection',
      theme: theme.themeData,
      darkTheme: AppThemeData.darkTheme,
      themeMode: theme.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
