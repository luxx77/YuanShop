import 'package:dio/dio.dart';
import 'package:hh_express/helpers/extentions.dart';

class LoggerInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final requestPath =
        '${options.baseUrl}${options.path} \n data:${options.data}';
    '!!! ${options.method} request => $requestPath'.log();
    '!!! Error: ${err.error}, Message: ${err.message}'.log(); // Error log
    if (err.response != null) {
      '!!! Error RESPONSE MESSAGE: ${err.response?.statusMessage}, Message: ${err.response?.data}, Error Message: ${err.message}'
          .log();
    }
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    '-> -> -> ${options.method} request => $requestPath \ndata:${options.data} \nqueryParams: ${options.queryParameters} \n headers: ${options.headers}'
        .log(); // Info log
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: unnecessary_statements
    '<- <- <- \n StatusCode: ${response.statusCode} \n Data: ${response.data}'
        .log();
    return super.onResponse(response, handler);
  }
}
