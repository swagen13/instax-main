import 'package:bloc/bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_event.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_state.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  PhoneNumberBloc() : super(PhoneNumberState('')) {
    on<UpdatePhoneNumber>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    });
  }
}
