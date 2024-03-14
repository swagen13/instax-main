import 'package:bloc/bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_event.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_state.dart';
import 'package:user_repository/user_repository.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  final UserRepository _userRepository;

  PhoneNumberBloc(this._userRepository) : super(const PhoneNumberState('')) {
    on<UpdatePhoneNumber>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    });

    on<PhoneVerifyRequired>((event, emit) async {
      emit(state.copyWith(status: PhoneNumberStatus.loading));
      try {
        final phonVerification =
            await _userRepository.phonVerify(event.phoneNumber);

        emit(state.copyWith(
            status: PhoneNumberStatus.success,
            verificationId: phonVerification));
      } catch (e) {
        print(e);
        emit(state.copyWith(status: PhoneNumberStatus.failure));
      }
    });

    on<SetVerificationId>((event, emit) async {
      emit(state.copyWith(verificationId: event.verificationId));
    });
  }
}
