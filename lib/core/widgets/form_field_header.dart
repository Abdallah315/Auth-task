import 'package:flutter/material.dart';
import '../theming/styles.dart';

class FormFieldHeader extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const FormFieldHeader({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style ?? TextStyles.font14RegularVariant);
  }
}
