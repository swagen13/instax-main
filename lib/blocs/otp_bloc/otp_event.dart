import 'package:equatable/equatable.dart';

abstract class OTPEvent extends Equatable {
  const OTPEvent();

  @override
  List<Object> get props => [];
}

class UpdateOTP extends OTPEvent {
  final String otp;

  const UpdateOTP(this.otp);

  @override
  List<Object> get props => [otp];
}

class VerifyOTP extends OTPEvent {
  final String phoneNumber;
  final String verificationId;
  final String smsCode;

  const VerifyOTP(
    this.phoneNumber,
    this.verificationId,
    this.smsCode,
  );

  @override
  List<Object> get props => [phoneNumber, verificationId, smsCode];
}
