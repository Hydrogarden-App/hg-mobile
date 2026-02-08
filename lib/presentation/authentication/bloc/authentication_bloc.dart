import "dart:async";
import "package:equatable/equatable.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:clerk_flutter/clerk_flutter.dart";
import "package:clerk_auth/clerk_auth.dart" as clerk; // Underlying SDK logic

import "package:hydrogarden_mobile/app/datasource/remote/client_provider.dart";
import "package:hydrogarden_mobile/domain/authentication/authentication_status.dart";

part "authentication_event.dart";
part "authentication_state.dart";

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ClerkAuthState _clerkAuth;
  final ClientProvider _clientProvider;

  AuthenticationBloc({
    required ClerkAuthState clerkAuth,
    required ClientProvider clientProvider,
  }) : _clerkAuth = clerkAuth,
       _clientProvider = clientProvider,
       super(const AuthenticationState.unknown()) {
    _clerkAuth.addListener(_onClerkStateChanged);
    _clerkAuth.errorStream.listen(_onError);

    on<AuthenticationCheckRequested>((event, emit) async {
      if (_clerkAuth.isSignedIn) {
        try {
          final sessionToken = await _clerkAuth.sessionToken();
          _clientProvider.updateToken(sessionToken.jwt);
          emit(AuthenticationState.authenticated(sessionToken.jwt));
        } catch (e) {
          debugPrint("Error obtaining session token: $e");
          emit(const AuthenticationState.unauthenticated());
        }
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });

    on<AuthenticationOAuthRequested>((event, emit) async {
      try {
        final strategy = switch (event.provider) {
          OAuthProvider.apple => clerk.Strategy.oauthApple,
          OAuthProvider.google => clerk.Strategy.oauthGoogle,
        };
        await _clerkAuth.ssoSignIn(event.context, strategy);
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

  void _onError(clerk.ClerkError error) {
    // Handle authentication errors if needed
    print("Clerk Authentication Error: ${error.message} (code: ${error.code})");
  }

  @override
  Future<void> close() {
    _clerkAuth.removeListener(_onClerkStateChanged);
    return super.close();
  }
}
