import 'dart:async';
import 'dart:io';

import 'package:auth_task/core/errors/custom_exceptions/custom_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_handler.g.dart';

class ErrorHandler {
  void handleError(DioException e, String endpoint) {
    debugPrint('MESSAGE FROM DioException:==>>from $endpoint ${e.message}');
    debugPrint(
      'STATUS CODE FROM DioException:==>>from $endpoint ${e.response?.statusCode}',
    );
    debugPrint('DATA FROM DioException:==>>from $endpoint ${e.response?.data}');

    throw ServerFailure.fromDiorError(e);
  }

  void handleGeneralError(Object error) {
    if (error is SocketException) {
      throw CustomException(message: "No internet connection.");
    } else if (error is TimeoutException) {
      throw CustomException(message: "Request timed out.");
    } else if (error is FormatException) {
      throw CustomException(message: "Invalid response format.");
    } else {
      throw CustomException(message: "Unexpected error occurred.");
    }
  }
}

class ServerFailure extends CustomException {
  ServerFailure(String message) : super(message: message);

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure('There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else {
      return ServerFailure('There was an error , please try again');
    }
  }
}

@riverpod
ErrorHandler errorHandler(Ref ref) {
  return ErrorHandler();
}
