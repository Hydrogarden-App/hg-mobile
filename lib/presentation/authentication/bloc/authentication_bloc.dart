import "dart:async";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:clerk_flutter/clerk_flutter.dart";
import "package:clerk_auth/clerk_auth.dart" as clerk; // Underlying SDK logic

import "package:hydrogarden_mobile/app/datasource/remote/client_provider.dart";
import "package:hydrogarden_mobile/domain/authentication/authentication_status.dart";

part "authentication_event.dart";
part "authentication_state.dart";

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ClerkAuthState _clerkAuth;
  final ClientProvider _clientProvider;

  AuthenticationBloc({
    required ClerkAuthState clerkAuth,
    required ClientProvider clientProvider,
  })  : _clerkAuth = clerkAuth,
        _clientProvider = clientProvider,
        super(const AuthenticationState.unknown()) {

    _clerkAuth.addListener(_onClerkStateChanged);
    _clerkAuth.errorStream.listen(_onError);

    on<AuthenticationCheckRequested>((event, emit) async {
      print("HUJ");
      if (_clerkAuth.isSignedIn) {
        print("SIGNED IN");
        // Clerk handles token refreshing automatically.
        // We just fetch the latest valid JWT for our API provider.
        final sessionToken = await _clerkAuth.sessionToken();
        if (sessionToken != null) {
          _clientProvider.updateToken(sessionToken.jwt);
          emit(AuthenticationState.authenticated(sessionToken.jwt));
        }
      } else {
        print("NOT SIGNED IN");
        emit(const AuthenticationState.unauthenticated());
      }
    });

    on<AuthenticationLoginRequested>((event, emit) async {
      print("KURWA");
      try {
        await _clerkAuth.attemptSignIn(
          strategy: clerk.Strategy.password,
          identifier: event.email,
          password: event.password,
        );
        // We don't manually emit here; _onClerkStateChanged will handle it.
      } catch (e) {
        emit(const AuthenticationState.unauthenticated());
      }
    });

    on<AuthenticationSignupRequested>((event, emit) async {
      print("dfhajlfd;ds");
      try {
        await _clerkAuth.attemptSignUp(
          strategy: clerk.Strategy.password, // Adjust based on your Clerk Dashboard settings
          emailAddress: event.email,

          password: event.password,
          passwordConfirmation: event.password
        );
      } catch (e) {
        emit(const AuthenticationState.unauthenticated());
      }
    });

    on<AuthenticationLogoutRequested>((event, emit) async {
      print("logout");
      await _clerkAuth.signOut();
    });

    add(AuthenticationCheckRequested());
  }

  void _onClerkStateChanged() {
    add(AuthenticationCheckRequested());
  }

  void _onError(clerk.AuthError error) {
    // Handle authentication errors if needed
    print("Authentication error: ${error.message}");
    print(error);
    print(error.code);
    print(error.argument);
  }


  @override
  Future<void> close() {
    _clerkAuth.removeListener(_onClerkStateChanged);
    return super.close();
  }
}
