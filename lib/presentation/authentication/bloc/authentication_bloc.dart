import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:hydrogarden_mobile/app/datasource/remote/client_provider.dart";
import "package:hydrogarden_mobile/domain/authentication/repositories/authentication_repository.dart";
import "package:hydrogarden_mobile/domain/authentication/authentication_status.dart";

part "authentication_event.dart";
part "authentication_state.dart";

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final ClientProvider _clientProvider;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required ClientProvider clientProvider,
  }) : _authenticationRepository = authenticationRepository,
       _clientProvider = clientProvider,
       super(const AuthenticationState.unknown()) {
    on<AuthenticationCheckRequested>((event, emit) async {
      final token = await _authenticationRepository.getToken();

      if (token != null) {
        _clientProvider.updateToken(token);
        emit(AuthenticationState.authenticated(token));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });

    on<AuthenticationSignupRequested>((event, emit) async {
      final token = await _authenticationRepository.register(
        email: event.email,
        password: event.password,
      );
      _clientProvider.updateToken(token);
      emit(AuthenticationState.authenticated(token));
    });

    on<AuthenticationLoginRequested>((event, emit) async {
      final token = await _authenticationRepository.login(
        email: event.email,
        password: event.password,
      );
      _clientProvider.updateToken(token);
      emit(AuthenticationState.authenticated(token));
    });

    on<AuthenticationLogoutRequested>((event, emit) async {
      await _authenticationRepository.logout();
      emit(AuthenticationState.unauthenticated());
    });

    add(AuthenticationCheckRequested());
  }
}
