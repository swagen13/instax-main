import 'package:bloc/bloc.dart';
import 'package:instax/blocs/otp_bloc/otp_event.dart';
import 'package:instax/blocs/otp_bloc/otp_state.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  OTPBloc() : super(OTPState('')) {
    on<UpdateOTP>((event, emit) {
      emit(state.copyWith(otp: event.otp));
    });
  }
}
