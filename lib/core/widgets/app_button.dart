import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final bool isLoading;
  final Color? color;
  final Size? size;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.color,
    this.size,
    this.textStyle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: size ?? Size.fromHeight(45),
        backgroundColor: color ?? ColorsManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Text(title, style: textStyle ?? TextStyles.font16MediumWhite),
      ),
    );
  }
}

class AppButtonWithImage extends StatelessWidget {
  final void Function()? onPressed;
  final Widget content;
  final bool isLoading;
  const AppButtonWithImage({
    super.key,
    required this.onPressed,
    required this.content,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromHeight(45),
        backgroundColor: ColorsManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: isLoading ? const CircularProgressIndicator.adaptive() : content,
      ),
    );
  }
}
