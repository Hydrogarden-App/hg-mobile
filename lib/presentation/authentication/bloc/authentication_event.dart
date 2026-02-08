part of "authentication_bloc.dart";

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

enum OAuthProvider { apple, google }

final class AuthenticationOAuthRequested extends AuthenticationEvent {
  final OAuthProvider provider;
  final BuildContext context;
  const AuthenticationOAuthRequested(this.provider, this.context);
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}

final class AuthenticationCheckRequested extends AuthenticationEvent {}

final class AuthenticationRefreshTokenRequested extends AuthenticationEvent {}
