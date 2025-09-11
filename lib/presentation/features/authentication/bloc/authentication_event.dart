part of "authentication_bloc.dart";

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class AuthenticationSignupRequested extends AuthenticationEvent {
  String email;
  String password;
  AuthenticationSignupRequested(this.email, this.password);
}

final class AuthenticationLoginRequested extends AuthenticationEvent {
  String email;
  String password;
  AuthenticationLoginRequested(this.email, this.password);
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}

final class AuthenticationRefreshTokenRequested extends AuthenticationEvent {}
