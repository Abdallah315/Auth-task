import 'package:auth_task/core/errors/custom_exceptions/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_loger.g.dart';

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    // * This can be replaced with a call to a crash reporting tool of choice
    debugPrint('$error, $stackTrace');
  }

  void logAppException(CustomException exception) {
    // * This can be replaced with a call to a crash reporting tool of choice
    debugPrint('$exception');
  }
}

@riverpod
ErrorLogger errorLogger(Ref ref) {
  return ErrorLogger();
}
