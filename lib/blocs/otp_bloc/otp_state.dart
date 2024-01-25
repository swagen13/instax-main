import 'package:equatable/equatable.dart';

enum OTPStatus { initial, success, failure, loading }

class OTPState extends Equatable {
  final OTPStatus status;
  final String otp;

  const OTPState(
    String otp, {
    this.status = OTPStatus.initial,
  }) : otp = otp;

  OTPState copyWith({
    OTPStatus? status,
    String? otp,
  }) {
    return OTPState(
      otp ?? this.otp,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, otp];
}
