import 'package:auth_task/features/auth/presentation/screens/login_screen.dart';
import 'package:auth_task/features/auth/presentation/screens/registration_screen.dart';
import 'package:flutter/material.dart' show NavigatorState, GlobalKey;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

enum AppRoutes { login, registration }

GlobalKey<NavigatorState> rootNavigator = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
// GlobalKey<NavigatorState> _shellNavigator = GlobalKey<NavigatorState>(
//   debugLabel: 'shell',
// );

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: rootNavigator,
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/registration',
        name: AppRoutes.registration.name,
        builder: (context, state) => const RegistrationScreen(),
      ),
    ],
  );
}
