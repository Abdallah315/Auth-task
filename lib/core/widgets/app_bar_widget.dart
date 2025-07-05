import 'package:auth_task/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back, color: Color(0xff475569), size: 24),
        ),
        Text(title, style: TextStyles.font18BoldBlack),
      ],
    );
  }
}
