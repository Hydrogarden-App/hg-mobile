abstract class AuthenticationLocalRepository {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
  Future<(String, String)?> readTokens();
  Future<void> removeTokens();
}
