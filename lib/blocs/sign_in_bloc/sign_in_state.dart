part of 'sign_in_bloc.dart';

enum SignInStatus { initial, success, loading, failure, progress, signout }

class SignInState extends Equatable {
  final SignInStatus status;
  final String? errorMessage;
  final AuthCredential? facebookAuth;
  final MultiFactorResolver? multiFactorResolver;
  final String? verificationId;
  final bool isLoading;

  const SignInState(
      {this.status = SignInStatus.initial,
      this.errorMessage,
      this.facebookAuth,
      this.multiFactorResolver,
      this.verificationId,
      this.isLoading = false});

  SignInState copyWith(
      {SignInStatus? status,
      String? errorMessage,
      AuthCredential? facebookAuth,
      MultiFactorResolver? multiFactorResolver,
      String? verificationId,
      bool? isLoading}) {
    return SignInState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        facebookAuth: facebookAuth ?? this.facebookAuth,
        multiFactorResolver: multiFactorResolver ?? this.multiFactorResolver,
        verificationId: verificationId ?? this.verificationId);
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, facebookAuth, multiFactorResolver, verificationId];
}
