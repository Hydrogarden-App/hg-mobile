part of "authentication_bloc.dart";

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class AuthenticationSignupRequested extends AuthenticationEvent {}

final class AuthenticationLoginRequested extends AuthenticationEvent {}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}

final class AuthenticationRefreshTokenRequested extends AuthenticationEvent {}
