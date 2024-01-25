import 'package:equatable/equatable.dart';

enum PhoneNumberStatus { initial, success, failure, loading }

class PhoneNumberState extends Equatable {
  final PhoneNumberStatus status;
  final String phoneNumber;

  const PhoneNumberState(
    String phoneNumber, {
    this.status = PhoneNumberStatus.initial,
  }) : phoneNumber = phoneNumber;

  PhoneNumberState copyWith({
    PhoneNumberStatus? status,
    String? phoneNumber,
  }) {
    return PhoneNumberState(
      phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, phoneNumber];
}
