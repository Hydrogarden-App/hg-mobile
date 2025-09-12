import "package:dio/dio.dart";
import "package:openapi/openapi.dart";

import "auth_interceptor.dart";

class ClientProvider {
  late final Dio _authDio;
  late final Dio _unauthDio;

  late final Openapi _authOpenapi;
  late final Openapi _unauthOpenapi;

  late final AuthInterceptor _interceptor;

  ClientProvider() {
    _authDio = Dio();
    _unauthDio = Dio();
    _unauthOpenapi = Openapi(dio: _authDio);
    _authOpenapi = Openapi(dio: _unauthDio);
    _interceptor = AuthInterceptor(dio: _authDio);
  }

  Openapi getUnauthenticatedClient() => _unauthOpenapi;
  Openapi getAuthenticatedClient() => _authOpenapi;

  void updateToken(String token) {
    _interceptor.setToken(token);
  }
}
