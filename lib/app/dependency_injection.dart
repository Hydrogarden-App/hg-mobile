import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";
import "package:hydrogarden_mobile/app/remote/client_provider.dart";
import "package:hydrogarden_mobile/data/authentication/repositories/authentication_local_repository_impl.dart";
import "package:hydrogarden_mobile/data/authentication/repositories/authentication_remote_repository_impl.dart";
import "package:hydrogarden_mobile/data/authentication/repositories/authentication_repository_impl.dart";
import "package:hydrogarden_mobile/domain/authentication/repositories/authentication_repository.dart";
import "package:hydrogarden_mobile/presentation/authentication/bloc/authentication_bloc.dart";

GetIt getIt = GetIt.instance;

void setup() {
  _setupClient();
  _setupRepository();
  _setupBloc();
}

void _setupClient() {
  getIt.registerSingleton<ClientProvider>(ClientProvider());
}

void _setupRepository() {
  getIt.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      localAuth: AuthenticationLocalRepositoryImpl(FlutterSecureStorage()),
      remoteAuth: AuthenticationRemoteRepositoryImpl(
        getIt.get<ClientProvider>().getUnauthenticatedClient(),
      ),
    ),
  );
}

void _setupBloc() {
  getIt.registerSingleton<AuthenticationBloc>(
    AuthenticationBloc(
      authenticationRepository: getIt<AuthenticationRepository>(),
      clientProvider: getIt<ClientProvider>(),
    ),
  );
}
