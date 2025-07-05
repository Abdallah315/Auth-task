import 'package:flutter/material.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class MainAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  const MainAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyles.font16SemiBoldNeutral100),
      actions: actions,
      centerTitle: true,
      leading: leading,
      flexibleSpace: Image.asset('assets/images/app-bar-bg.png'),
      backgroundColor: ColorsManager.neutral100,
      iconTheme: const IconThemeData(color: ColorsManager.neutral20),
    );
  }
}
