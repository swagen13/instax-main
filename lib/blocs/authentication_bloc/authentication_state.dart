part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown, progress }

enum AppLifecycleState { resumed, paused }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;
  final String? appLifecycleState;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
    this.appLifecycleState,
  });

  /// No information about the [AuthenticationStatus] of the current user.
  const AuthenticationState.unknown() : this._();

  /// Current user is [authenticated].
  ///
  /// It takes a [MyUser] property representing the current [authenticated] user.
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  /// Current user is [unauthenticated].
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  // app lifecycle state
  const AuthenticationState.appLifecycleChanged(
    this.status,
    this.user,
    this.appLifecycleState,
  );

  /// Current authentication state is [progress].
  const AuthenticationState.progress()
      : this._(status: AuthenticationStatus.progress);

  @override
  List<Object?> get props => [status, user];
}
