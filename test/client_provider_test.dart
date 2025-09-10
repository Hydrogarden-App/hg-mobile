// import "package:flutter_test/flutter_test.dart";
// import "package:hydrogarden_mobile/app/remote/auth_interceptor.dart";
// import "package:hydrogarden_mobile/app/remote/client_provider.dart";

// void main() {
//   test("ClientProvider interceptor management", () {
//     final clientProvider = ClientProvider();

//     // 1. Get unauthenticated client and verify no interceptor
//     final unauthClient = clientProvider.getUnauthenticatedClient();
//     final dioFromUnauthClient = unauthClient.dio;
//     expect(
//       dioFromUnauthClient.interceptors.any((i) => i is AuthInterceptor),
//       false,
//     );

//     // 2. Get authenticated client and verify interceptor is added
//     final authClient = clientProvider.getAuthenticatedClient("dummy-token");
//     final dioFromAuthClient = authClient.dio;
//     expect(
//       dioFromAuthClient.interceptors.any((i) => i is AuthInterceptor),
//       true,
//     );

//     // 3. Get unauthenticated client again and verify interceptor is removed
//     final unauthClientAgain = clientProvider.getUnauthenticatedClient();
//     final dioFromUnauthAgain = unauthClientAgain.dio;
//     expect(
//       dioFromUnauthAgain.interceptors.any((i) => i is AuthInterceptor),
//       false,
//     );
//   });
// }
