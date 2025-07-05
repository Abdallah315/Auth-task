import 'package:auth_task/core/routes/routes.dart';
import 'package:auth_task/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Auth Task',
      locale: const Locale('en'),
      theme: ThemeData(
        dividerTheme: const DividerThemeData(color: Colors.transparent),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: ColorsManager.primary,

          onPrimary: ColorsManager.darkWhite,
          secondary: ColorsManager.neutral100,
          onSecondary: ColorsManager.darkWhite,
          error: ColorsManager.destructiveBase,
          onError: ColorsManager.darkWhite,
          surface: ColorsManager.darkWhite,
          onSurface: ColorsManager.neutral100,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
