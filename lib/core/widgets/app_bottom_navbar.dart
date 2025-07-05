import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theming/colors.dart';

class AppBottomNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  final bool show;
  const AppBottomNavBar({
    super.key,
    required this.navigationShell,
    required this.show,
  });

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(initialLocation: true, index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: show,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: .1),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.inter(),
          unselectedLabelStyle: GoogleFonts.inter(),
          type: BottomNavigationBarType.fixed,
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svgs/home-inactive.svg'),
              activeIcon: SvgPicture.asset('assets/svgs/home-active.svg'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svgs/orders-inactive.svg'),
              activeIcon: SvgPicture.asset('assets/svgs/orders-active.svg'),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svgs/profile-inactive.svg'),
              activeIcon: SvgPicture.asset('assets/svgs/profile-active.svg'),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 20,
          showUnselectedLabels: true,
          unselectedItemColor: ColorsManager.neutral80,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
