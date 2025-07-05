import 'package:auth_task/core/helpers/sizes.dart';
import 'package:auth_task/core/theming/colors.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const FullScreenLoader({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: ColorsManager.white,
      child: Stack(
        children: [
          child, // Main UI
          if (isLoading) // Show overlay when loading
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: Center(
                  child: Container(
                    width: getWidth(context) * .3,
                    height: getHeight(context) * .15,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorsManager.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator.adaptive(),
                        verticalSpace(10),
                        Text('Loading...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
