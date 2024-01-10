import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hh_express/data/local/secured_storage.dart';
import 'package:hh_express/data/remote/interceptors/log_interceptor.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/overlay_helper.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/models/api/response_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';
import 'package:hh_express/settings/globals.dart';

mixin DioClientMixin {
  final _DioClient _dio = _DioClient();
  _DioClient get dio => _dio;
}

class _DioClient {
  _DioClient({
    String? baseUrl,
    ResponseType? type,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? EndPoints.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
            responseType: type ?? ResponseType.json,
          ),
        )..interceptors.addAll(
            [
              LoggerInterceptor(),
              InterceptorsWrapper(
                onResponse: (res, handler) {
                  'end response'.log();
                  handler.next(res);
                },
                onRequest: (options, handler) async {
                  handler.next(options);
                },
                onError: (e, handler) async {
                  handler.next(e);
                },
              )
            ],
          );

  late final Dio _dio;
  Options addHeaders(Options? options) {
    final token = LocalStorage.getToken;
    final langHead = {
      'Accept': 'application/json',
      'Accept-Language': locale.value == 'tr' ? 'tk' : locale.value,
      'Authorization': 'Bearer $token',
    };
    if (options == null) return Options(headers: langHead);
    return options.copyWith(
      headers: options.headers!..addAll(langHead),
    );
  }

  Future<ApiResponse> post({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        endPoint,
        data: data,
        options: addHeaders(options),
      );
      return ApiResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (e, s) {
      'zero Step'.log();

      return _handleException(e, s);
    }
  }

  Future<ApiResponse> get({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        endPoint,
        data: data,
        options: addHeaders(options),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return ApiResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (e, s) {
      'ERROR GET'.log();
      return _handleException(e, s);
    }
  }

  Future<ApiResponse> delete({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endPoint,
        data: data,
        options: addHeaders(options),
        queryParameters: queryParameters,
      );
      return ApiResponse.fromJson(response.data);
    } catch (e, s) {
      e.log();
      return _handleException(e, s);
    }
  }
}

ApiResponse _handleException(Object e, StackTrace? stack) {
  final isDioExeption = e is DioException;

  if (!isDioExeption) {
    SnackBarHelper.showTopSnack(
      e.toString(),
      APIState.error,
    );
    return ApiResponse.unknownError;
  }

  if (e.error is SocketException || e.response?.statusCode == 104) {
    SnackBarHelper.showTopSnack(
      appRouter.currentContext.l10n.socketExeption,
      APIState.error,
    );
    return ApiResponse(
      data: {},
      error: 'SocketExeption',
      message: 'Socket Exeption Show Some TellSomeThing',
      success: false,
    );
  }
  if (e.response != null && e.response!.data is Map) {
    '${e.requestOptions.data} MyDioExeption'.log();
    SnackBarHelper.showTopSnack(
      e.response!.data['message'] ??
          appRouter.currentContext.l10n.socketExeption,
      APIState.error,
    );
    return ApiResponse.fromJson(e.response!.data);
  }
  SnackBarHelper.showTopSnack(
    e.message ?? e.error.toString(),
    APIState.error,
  );
  return ApiResponse.unknownError;
}
