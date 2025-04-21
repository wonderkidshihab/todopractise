library;

import 'package:dio/dio.dart';
import 'package:fluttercleanprojectstarter/src/core/api/base_response.dart';
import 'package:fluttercleanprojectstarter/src/core/error/error.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ApiInterface {
  Future<Either<Failure, BaseResponse>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
  Future<Either<Failure, BaseResponse>> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  });
  Future<Either<Failure, BaseResponse>> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  });
  Future<Either<Failure, BaseResponse>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  });
  Future<Either<Failure, BaseResponse>> patch(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  });
}

class DioApi extends ApiInterface {
  final Dio _dio;
  DioApi({required Dio dio}) : _dio = dio {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: body,
      );
      return Right(
        BaseResponseImpl(
          data: response.data,
          message: response.statusMessage,
          statusCode: response.statusCode,
          success: response.statusCode == 200,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters, options: Options(headers: headers));
      return Right(
        BaseResponseImpl(
          data: response.data,
          message: response.statusMessage,
          statusCode: response.statusCode,
          success: response.statusCode == 200,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> patch(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: body,
      );
      return Right(
        BaseResponseImpl(
          data: response.data,
          message: response.statusMessage,
          statusCode: response.statusCode,
          success: response.statusCode == 200,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.post(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: body,
      );
      return Right(
        BaseResponseImpl(
          data: response.data,
          message: response.statusMessage,
          statusCode: response.statusCode,
          success: response.statusCode == 200,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.put(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: body,
      );
      return Right(
        BaseResponseImpl(
          data: response.data,
          message: response.statusMessage,
          statusCode: response.statusCode,
          success: response.statusCode == 200,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Failure _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.sendTimeout:
        return const NetworkFailure('Send timeout');
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Receive timeout');
      case DioExceptionType.badCertificate:
        return const NetworkFailure('Bad certificate');
      case DioExceptionType.badResponse:
        return const ServerFailure('Bad response');
      case DioExceptionType.cancel:
        return const UnknownFailure('Request cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure('Connection error');
      default:
        return const UnknownFailure('Unknown error');
    }
  }
}
