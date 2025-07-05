import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class AppTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final bool isLoading;
  final Size? size;
  final Color? color;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.color,
    this.size,
    this.backgroundColor,
    this.isLoading = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        fixedSize: size ?? Size.fromHeight(45),
        backgroundColor: backgroundColor ?? ColorsManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color ?? ColorsManager.primary, width: 1),
        ),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Text(
                title,
                style:
                    textStyle ??
                    TextStyles.font16MediumPrimary.copyWith(
                      color: color ?? ColorsManager.primary,
                    ),
              ),
      ),
    );
  }
}
