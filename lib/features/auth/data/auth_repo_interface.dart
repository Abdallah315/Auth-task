import 'package:auth_task/features/auth/domain/login_request_body.dart';
import 'package:auth_task/features/auth/domain/register_request_body.dart';

abstract class IAuthRepo {
  Future<void> register(RegisterRequestBody registerRequestBody);
  Future<void> login(LoginRequestBody loginRequestBody);
}
