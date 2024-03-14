part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User? user;

  const AuthenticationUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthCheckRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class AuthenticationReload extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
