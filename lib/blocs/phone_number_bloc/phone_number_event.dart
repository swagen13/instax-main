import 'package:equatable/equatable.dart';

abstract class PhoneNumberEvent extends Equatable {
  const PhoneNumberEvent();

  @override
  List<Object> get props => [];
}

class UpdatePhoneNumber extends PhoneNumberEvent {
  final String phoneNumber;

  const UpdatePhoneNumber(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
