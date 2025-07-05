import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_bottom_navbar.dart';

class MainNavigationScaffold extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  final bool showBottomNavBar;
  const MainNavigationScaffold({
    super.key,
    required this.navigationShell,
    required this.showBottomNavBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        navigationShell: navigationShell,
        show: showBottomNavBar,
      ),
    );
  }
}
