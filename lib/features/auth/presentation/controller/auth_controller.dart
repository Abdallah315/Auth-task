import 'package:auth_task/features/auth/data/auth_repository.dart';
import 'package:auth_task/features/auth/domain/login_request_body.dart';
import 'package:auth_task/features/auth/domain/register_request_body.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  bool mounted = true;
  @override
  FutureOr build() {
    ref.onDispose(() => mounted = false);
  }

  Future<void> register({
    required RegisterRequestBody registerRequestBody,
    Function()? onSuccess,
    Function(Object)? onError,
  }) async {
    state = AsyncLoading();
    final newState = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).register(registerRequestBody),
    );
    if (mounted) {
      state = newState;
      if (state.hasError == false) {
        onSuccess?.call();
      } else {
        onError?.call(state.error!);
      }
    }
  }

  Future<void> login({
    required LoginRequestBody loginRequestBody,
    Function()? onSuccess,
    Function(Object)? onError,
  }) async {
    state = AsyncLoading();
    final newState = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(loginRequestBody),
    );
    if (mounted) {
      state = newState;
      if (state.hasError == false) {
        onSuccess?.call();
      } else {
        onError?.call(state.error!);
      }
    }
  }
}
