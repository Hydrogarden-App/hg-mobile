import "package:hydrogarden_mobile/domain/repository/authentication_local_repository.dart";
import "package:hydrogarden_mobile/domain/repository/authentication_remote_repository.dart";
import "package:hydrogarden_mobile/domain/repository/authentication_repository.dart";

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalRepository _localAuth;
  final AuthenticationRemoteRepository _remoteAuth;

  const AuthenticationRepositoryImpl({
    required AuthenticationLocalRepository localAuth,
    required AuthenticationRemoteRepository remoteAuth,
  }) : _localAuth = localAuth,
       _remoteAuth = remoteAuth;

  @override
  @override
  Future<String?> getToken() async {
    final tokens = await _localAuth.readTokens();
    return tokens?.$1;
  }

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final (accessToken, refreshToken) = await _remoteAuth.login(
      email: email,
      password: password,
    );
    await _localAuth.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    return accessToken;
  }

  @override
  Future<void> logout() async {
    await _localAuth.removeTokens();
  }

  @override
  Future<String?> refreshToken() async {
    final tokens = await _localAuth.readTokens();
    if (tokens == null) return null;
    final newToken = await _remoteAuth.refreshAccessToken(
      refreshToken: tokens.$2,
    );
    await _localAuth.saveTokens(accessToken: newToken, refreshToken: tokens.$2);
    return newToken;
  }

  @override
  Future<String> register({
    required String email,
    required String password,
  }) async {
    final (accessToken, refreshToken) = await _remoteAuth.register(
      email: email,
      password: password,
    );
    await _localAuth.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    return accessToken;
  }
}
