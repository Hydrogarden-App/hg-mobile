import "package:hydrogarden_mobile/domain/authentication/repositories/authentication_remote_repository.dart";
import "package:openapi/openapi.dart";

class AuthenticationRemoteRepositoryImpl
    implements AuthenticationRemoteRepository {
  // ignore: unused_field
  final Openapi _client;

  AuthenticationRemoteRepositoryImpl(this._client);

  @override
  Future<(String, String)> login({
    required String email,
    required String password,
  }) async {
    return ("AuthToken", "RefreshToken");
  }

  @override
  Future<String> refreshAccessToken({required String refreshToken}) async {
    return "AuthToken";
  }

  @override
  Future<(String, String)> register({
    required String email,
    required String password,
  }) async {
    return ("AuthToken", "RefreshToken");
  }
}
