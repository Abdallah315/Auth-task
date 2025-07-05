import 'package:auth_task/core/errors/custom_exceptions/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const kDialogDefaultKey = Key('dialog-default-key');

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  String defaultActionText = 'OK',
}) async {
  return showDialog(
    context: context,
    // * Only make the dialog dismissible if there is a cancel button
    barrierDismissible: cancelActionText != null,
    // * AlertDialog.adaptive was added in Flutter 3.13
    builder: (context) => AlertDialog.adaptive(
      title: Text(title),
      content: content != null ? Text(content) : null,
      // * Use [TextButton] or [CupertinoDialogAction] depending on the platform
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText),
            onPressed: () => context.pop(false),
          ),
        TextButton(
          key: kDialogDefaultKey,
          child: Text(defaultActionText),
          onPressed: () => context.pop(true),
        ),
      ],
    ),
  );
}

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) {
  return showAlertDialog(
    context: context,
    title: title,
    content: exception is CustomException
        ? exception.message
        : exception.toString(),
    defaultActionText: 'OK',
  );
}
