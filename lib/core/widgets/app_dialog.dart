import 'package:flutter/material.dart';
import '../helpers/sizes.dart';

Future<void> dialogBuilder({
  required BuildContext context,
  required Widget content,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: getWidth(context) * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: content,
        ),
      );
    },
    barrierDismissible: true,
    useSafeArea: false,
    useRootNavigator: true,
  );
}
