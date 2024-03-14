import 'package:bloc/bloc.dart';
import 'package:instax/blocs/otp_bloc/otp_event.dart';
import 'package:instax/blocs/otp_bloc/otp_state.dart';
import 'package:user_repository/user_repository.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  final UserRepository _userRepository;

  OTPBloc(this._userRepository) : super(OTPState('')) {
    on<UpdateOTP>((event, emit) {
      emit(state.copyWith(otp: event.otp));
    });

    on<VerifyOTP>((event, emit) async {
      emit(state.copyWith(status: OTPStatus.loading));
      try {
        await _userRepository.verifyOTP(
            event.phoneNumber, event.verificationId, event.smsCode);

        emit(state.copyWith(status: OTPStatus.success));
      } catch (e) {
        // print(e);
        emit(state.copyWith(status: OTPStatus.failure));
      }
    });
  }
}
