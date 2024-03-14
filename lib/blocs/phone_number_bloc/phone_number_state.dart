import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum PhoneNumberStatus { initial, success, failure, loading }

class PhoneNumberState extends Equatable {
  final PhoneNumberStatus status;
  final String phoneNumber;
  final String verificationId;
  final MultiFactorResolver? multiFactorResolver;

  const PhoneNumberState(
    this.phoneNumber, {
    this.status = PhoneNumberStatus.initial,
    this.verificationId = '',
    this.multiFactorResolver,
  });

  PhoneNumberState copyWith(
      {PhoneNumberStatus? status,
      String? phoneNumber,
      String? verificationId,
      MultiFactorResolver? multiFactorResolver}) {
    return PhoneNumberState(phoneNumber ?? this.phoneNumber,
        status: status ?? this.status,
        verificationId: verificationId ?? this.verificationId,
        multiFactorResolver: multiFactorResolver ?? this.multiFactorResolver);
  }

  @override
  List<Object?> get props =>
      [status, phoneNumber, verificationId, multiFactorResolver];
}
