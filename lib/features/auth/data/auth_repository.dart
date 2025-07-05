import 'package:auth_task/features/auth/constants/auth_api_routes.dart';
import 'package:auth_task/features/auth/data/auth_repo_interface.dart';
import 'package:auth_task/features/auth/domain/login_request_body.dart';
import 'package:auth_task/features/auth/domain/register_request_body.dart';
import 'package:auth_task/core/helpers/constants.dart';
import 'package:auth_task/core/helpers/extensions.dart';
import 'package:auth_task/core/helpers/shared_pref_helpers.dart';
import 'package:auth_task/core/networking/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepo implements IAuthRepo {
  final Ref ref;
  AuthRepo(this.ref);

  @override
  Future<void> register(RegisterRequestBody registerRequestBody) async {
    final apiService = ref.watch(getApiServiceProvider);
    try {
      await apiService.post(
        endpoint: AuthApiRoutes.register,
        body: registerRequestBody.toMap(),
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> login(LoginRequestBody loginRequestBody) async {
    final apiService = ref.watch(getApiServiceProvider);
    try {
      final response = await apiService.post(
        endpoint: AuthApiRoutes.login,
        body: loginRequestBody.toMap(),
      );
      await saveUserToken(response.data.accessToken);
      isLoggedInUser = true;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> saveUserToken(String accessToken) async {
    final token = accessToken;
    await ref
        .read(sharedPrefHelperProvider)
        .setSecuredString(SharedPrefKeys.token, token);
    ref.read(getDioFactoryProvider).setTokenIntoHeaderAfterLogin(token);
  }

  Future<void> checkIfUserLoggedIn() async {
    final String userToken = await ref
        .read(sharedPrefHelperProvider)
        .getSecuredString(SharedPrefKeys.token);
    if (userToken.isNullOrEmpty()) {
      isLoggedInUser = false;
    } else {
      isLoggedInUser = true;
    }
  }
}

@riverpod
IAuthRepo authRepository(Ref ref) {
  return AuthRepo(ref);
}
