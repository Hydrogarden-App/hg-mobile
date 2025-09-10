// import "package:dio/dio.dart";
// import "package:hydrogarden_mobile/api/lib/src/api.dart";

// import "auth_interceptor.dart";

// class ClientProvider {
//   late final Dio _dio;

//   late final Openapi _openapi;
//   late final AuthInterceptor _interceptor;

//   ClientProvider() {
//     _dio = Dio();
//     _openapi = Openapi(dio: _dio);
//     _interceptor = AuthInterceptor(dio: _dio);
//   }

//   Openapi getUnauthenticatedClient() {
//     _dio.interceptors.remove(_interceptor);
//     return _openapi;
//   }

//   Openapi getAuthenticatedClient(String token) {
//     _interceptor.setToken(token);
//     if (!_dio.interceptors.contains(_interceptor)) {
//       _dio.interceptors.add(_interceptor);
//     }
//     return _openapi;
//   }
// }
