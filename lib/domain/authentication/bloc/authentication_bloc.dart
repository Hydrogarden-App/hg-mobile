import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:hydrogarden_mobile/domain/authentication/authentication_status.dart";

part "authentication_event.dart";
part "authentication_state.dart";

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unknown());
}
