import 'package:equatable/equatable.dart';

abstract class PhoneNumberEvent extends Equatable {
  const PhoneNumberEvent();

  @override
  List<Object> get props => [];
}

class UpdatePhoneNumber extends PhoneNumberEvent {
  final String phoneNumber;

  const UpdatePhoneNumber(this.phoneNumber);
}

class PhoneVerifyRequired extends PhoneNumberEvent {
  final String phoneNumber;
  const PhoneVerifyRequired(this.phoneNumber);
}

class SetVerificationId extends PhoneNumberEvent {
  final String? verificationId;
  const SetVerificationId(this.verificationId);
}
