part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  const SignInRequired(this.email, this.password);
}

class SignOutRequired extends SignInEvent {
  const SignOutRequired();
}

class SignInWithFacebookRequired extends SignInEvent {
  const SignInWithFacebookRequired();
}

class SignInWithGoogle extends SignInEvent {
  const SignInWithGoogle();
}

class SignInWithLine extends SignInEvent {
  const SignInWithLine();
}

class SignInWithAnonymously extends SignInEvent {
  const SignInWithAnonymously();
}

class LinkingAccount extends SignInEvent {
  const LinkingAccount();
}

class SendVerificationMessage extends SignInEvent {
  final MultiFactorResolver? multiFactorResolver;

  const SendVerificationMessage(
    this.multiFactorResolver,
  );
}

class MultiFactorVerification extends SignInEvent {
  final String? smsCode;

  const MultiFactorVerification(this.smsCode);
}

class EmailVerification extends SignInEvent {
  const EmailVerification();
}

class SignInProgress extends SignInEvent {
  const SignInProgress();
}

class EmailVerificationSuccess extends SignInEvent {
  const EmailVerificationSuccess();
}
