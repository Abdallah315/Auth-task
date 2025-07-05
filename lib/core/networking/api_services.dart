import 'dart:async';

import 'package:auth_task/core/errors/error_handler.dart';
import 'package:auth_task/core/helpers/constants.dart';
import 'package:auth_task/core/helpers/shared_pref_helpers.dart';
import 'package:auth_task/core/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_services.g.dart';

class DioFactory {
  final Ref ref;
  DioFactory(this.ref);
  Dio? _dio;

  Future<Dio> getDio() async {
    Duration timeOut = const Duration(seconds: 120);
    if (_dio == null) {
      _dio = Dio();
      _dio?.options.connectTimeout = timeOut;
      _dio?.options.receiveTimeout = timeOut;
      await addDioHeaders();
      addDioInterceptor();
      return _dio!;
    } else {
      return _dio!;
    }
  }

  Future<void> addDioHeaders() async {
    _dio?.options.baseUrl = ApiRoutes.apiBaseUrl;
    _dio?.options.headers = {
      Headers.contentTypeHeader: 'application/json',
      Headers.acceptHeader: 'application/json;charset=UTF-8',
      'Connection': 'keep-alive',
      'Authorization':
          'bearer ${await ref.read(sharedPrefHelperProvider).getSecuredString(SharedPrefKeys.token)}',
    };
  }

  void addDioInterceptor() {
    _dio?.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final router = ref.read(goRouterProvider);

            // Clear user token
            await ref.read(getDioFactoryProvider).deleteUserToken();

            // Push login screen if not already on it
            router.goNamed(AppRoutes.login.name);
          }
          return handler.next(error); // Continue error handling
        },
      ),
    ]);
  }

  void setTokenIntoHeaderAfterLogin(String token) {
    _dio?.options.headers = {'Authorization': 'bearer $token'};
  }

  Future<void> deleteUserToken() async {
    final sharedPrefHelper = ref.read(sharedPrefHelperProvider);
    await sharedPrefHelper.clearAllData();
    await sharedPrefHelper.clearAllSecuredData();
  }
}

class ApiService {
  final Ref ref;

  ApiService(this.ref);

  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final dio = await ref.watch(getDioFactoryProvider).getDio();
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      ref.read(errorHandlerProvider).handleError(e, endpoint);
      rethrow;
    } catch (error) {
      ref.read(errorHandlerProvider).handleGeneralError(error);
      rethrow;
    }
  }

  Future<Response> post({
    required String endpoint,
    required Map<String, dynamic> body,
    List? listBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final dio = await ref.watch(getDioFactoryProvider).getDio();

      final response = await dio.post(
        endpoint,
        data: listBody ?? body,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      ref.read(errorHandlerProvider).handleError(e, endpoint);
      rethrow;
    } catch (error) {
      ref.read(errorHandlerProvider).handleGeneralError(error);
      rethrow;
    }
  }

  Future<Response> sendFormData({
    required FormData body,
    required String endpoint,
  }) async {
    try {
      final dio = await ref.watch(getDioFactoryProvider).getDio();

      final response = await dio.post(endpoint, data: body);
      return response;
    } on DioException catch (e) {
      ref.read(errorHandlerProvider).handleError(e, endpoint);
      rethrow;
    } catch (error) {
      ref.read(errorHandlerProvider).handleGeneralError(error);
      rethrow;
    }
  }

  Future<Response> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final dio = await ref.watch(getDioFactoryProvider).getDio();

      final response = await dio.put(
        endpoint,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      ref.read(errorHandlerProvider).handleError(e, endpoint);
      rethrow;
    } catch (error) {
      ref.read(errorHandlerProvider).handleGeneralError(error);
      rethrow;
    }
  }

  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final dio = await ref.watch(getDioFactoryProvider).getDio();

      final response = await dio.delete(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      ref.read(errorHandlerProvider).handleError(e, endpoint);
      rethrow;
    } catch (error) {
      ref.read(errorHandlerProvider).handleGeneralError(error);
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
ApiService getApiService(Ref ref) {
  return ApiService(ref);
}

@Riverpod(keepAlive: true)
DioFactory getDioFactory(Ref ref) {
  return DioFactory(ref);
}
