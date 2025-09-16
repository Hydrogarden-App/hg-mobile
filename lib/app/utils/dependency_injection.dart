import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";
import "package:hydrogarden_mobile/app/datasource/remote/client_provider.dart";
import "package:hydrogarden_mobile/data/authentication/repositories/authentication_local_repository_impl.dart";
import "package:hydrogarden_mobile/data/authentication/repositories/authentication_remote_repository_impl.dart";
import "package:hydrogarden_mobile/data/authentication/repositories/authentication_repository_impl.dart";
import "package:hydrogarden_mobile/domain/device/manager/device_sync_manager.dart";
import "package:hydrogarden_mobile/data/device/repositories/device_info_repository_local_impl.dart";
import "package:hydrogarden_mobile/data/device/repositories/device_info_repository_remote_impl.dart";
import "package:hydrogarden_mobile/data/device/repositories/device_state_repository_remote_impl.dart";
import "package:hydrogarden_mobile/data/device/repositories/mocks/device_info_repository_mock.dart";
import "package:hydrogarden_mobile/data/device/repositories/mocks/device_state_repository_mock.dart";
import "package:hydrogarden_mobile/domain/authentication/repositories/authentication_repository.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_state_repository.dart";
import "package:hydrogarden_mobile/presentation/authentication/bloc/authentication_bloc.dart";

GetIt getIt = GetIt.instance;

void setupGetIt() {
  _setupClient();
  _setupRepository();
  _setupBloc();
}

void _setupClient() {
  getIt.registerSingleton<ClientProvider>(ClientProvider());
  getIt.registerSingleton<Connectivity>(Connectivity());
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
  getIt.registerSingleton<DeviceInfoRepositoryLocalImpl>(
    DeviceInfoRepositoryLocalImpl(),
  );
  getIt.registerSingleton<DeviceInfoRepositoryRemoteImpl>(
    DeviceInfoRepositoryRemoteImpl(
      getIt.get<ClientProvider>().getAuthenticatedClient(),
    ),
  );
  getIt.registerSingleton<DeviceStateRepository>(
    DeviceStateRepositoryRemoteImpl(
      getIt.get<ClientProvider>().getAuthenticatedClient(),
    ),
  );
  getIt.registerSingleton<DeviceInfoRepositoryMock>(DeviceInfoRepositoryMock());
  getIt.registerSingleton<DeviceStateRepositoryMock>(
    DeviceStateRepositoryMock(),
  );

  getIt.registerSingleton<DeviceSyncManager>(
    DeviceSyncManager(
      localDeviceInfoRepository: getIt.get<DeviceInfoRepositoryLocalImpl>(),
      remoteDeviceInfoRepository: getIt.get<DeviceInfoRepositoryMock>(),
      deviceStateRepository: getIt.get<DeviceStateRepositoryMock>(),
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
