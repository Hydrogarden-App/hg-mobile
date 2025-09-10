import "package:dio/dio.dart";

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final Future<String?> Function()? onTokenRefresh;
  final void Function()? onUnauthorized;
  String? _token;

  AuthInterceptor({
    required this.dio,
    this.onTokenRefresh,
    this.onUnauthorized,
    String? token,
  }) : _token = token;

  void setToken(String? token) {
    _token = token;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_token != null) {
      options.headers["Authorization"] = "Bearer $_token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && onTokenRefresh != null) {
      try {
        final newToken = await onTokenRefresh!();
        if (newToken != null) {
          _token = newToken;

          final opts = err.requestOptions;
          opts.headers["Authorization"] = "Bearer $newToken";

          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } else {
          onUnauthorized?.call();
        }
      } catch (e) {
        onUnauthorized?.call();
      }
    }
    return handler.reject(err);
  }
}
