import 'package:auth_task/core/errors/custom_exceptions/custom_exception.dart';
import 'package:auth_task/core/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../widgets/alert_dialog.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        showExceptionAlertDialog(
          context: context,
          title: 'Error',
          exception: error,
        );
      }
    }
  }
}

class AsyncValueWidget<T> extends StatefulWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.customErrorWidget,
  });
  final AsyncValue<T> value;
  final Widget? customErrorWidget;
  final Widget Function(T) data;

  @override
  State<AsyncValueWidget<T>> createState() => _AsyncValueWidgetState<T>();
}

class _AsyncValueWidgetState<T> extends State<AsyncValueWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.value.when(
      data: widget.data,
      error: (e, st) {
        debugPrint('error stack trace: ${st.toString()}');
        debugPrint('error message: ${e.toString()}');
        return Center(
          child:
              widget.customErrorWidget ??
              CustomErrorWidget(
                message: e is CustomException ? e.message : e.toString(),
              ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

/// Sliver equivalent of [AsyncValueWidget]
class AsyncValueSliverWidget<T> extends StatefulWidget {
  const AsyncValueSliverWidget({
    super.key,
    required this.value,
    required this.data,
    this.customErrorWidget,
  });
  final AsyncValue<T> value;
  final Widget? customErrorWidget;
  final Widget Function(T) data;

  @override
  State<AsyncValueSliverWidget<T>> createState() =>
      _AsyncValueSliverWidgetState<T>();
}

class _AsyncValueSliverWidgetState<T> extends State<AsyncValueSliverWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.value.when(
      data: widget.data,
      loading: () => SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
      error: (e, st) {
        debugPrint('error stack trace: ${st.toString()}');
        debugPrint('error message: ${e.toString()}');
        return SliverToBoxAdapter(
          child:
              widget.customErrorWidget ??
              Center(child: CustomErrorWidget(message: st.toString())),
        );
      },
    );
  }
}
