import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final Function(String?)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool showGreyedText;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.readOnly,
    this.maxLines,
    this.maxLength,
    this.focusNode,
    required this.hintText,
    this.keyboardType,
    this.onChanged,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.showGreyedText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      maxLines: maxLines,
      maxLength: maxLength,
      focusNode: focusNode,
      decoration: InputDecoration(
        isDense: true,
        errorMaxLines: 3,
        counterText: "",
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.primary,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.neutral40,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: hintStyle ?? TextStyles.font12RegularNeutral60,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? Colors.white,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: showGreyedText
          ? TextStyles.font14RegularNeutral80
          : inputTextStyle ?? TextStyles.font14RegularBlack,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
