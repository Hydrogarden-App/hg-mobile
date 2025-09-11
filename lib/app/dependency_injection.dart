import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";
import "package:hydrogarden_mobile/app/remote/client_provider.dart";
import "package:hydrogarden_mobile/data/repository/authentication_local_repository_impl.dart";
import "package:hydrogarden_mobile/data/repository/authentication_remote_repository_impl.dart";
import "package:hydrogarden_mobile/data/repository/authentication_repository_impl.dart";

GetIt getIt = GetIt.instance;

void setup() {
  _setupClient();
  _setupRepository();
}

void _setupClient() {
  getIt.registerSingleton(ClientProvider());
}

void _setupRepository() {
  getIt.registerSingleton(
    () => AuthenticationRepositoryImpl(
      localAuth: AuthenticationLocalRepositoryImpl(FlutterSecureStorage()),
      remoteAuth: AuthenticationRemoteRepositoryImpl(
        getIt.get<ClientProvider>().getUnauthenticatedClient(),
      ),
    ),
  );
}
