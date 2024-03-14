import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const SignInState()) {
    on<SignInRequired>((event, emit) async {
      emit(state.copyWith(status: SignInStatus.loading));
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(state.copyWith(status: SignInStatus.success));
      } catch (e) {
        print(e.toString());
        emit(state.copyWith(
            status: SignInStatus.failure, errorMessage: e.toString()));
      }
    });
    on<SignInWithFacebookRequired>((event, emit) async {
      try {
        await _userRepository.signInWithFacebook();

        emit(state.copyWith(status: SignInStatus.success));
      } catch (e) {
        final FirebaseAuthException firebaseError = e as FirebaseAuthException;

        if (firebaseError.code == "account-exists-with-different-credential") {
          print('error is ${firebaseError.code}');
          emit(state.copyWith(
              status: SignInStatus.failure,
              errorMessage: firebaseError.code,
              facebookAuth: firebaseError.credential!));
        } else if (firebaseError.code == "second-factor-required") {
          final FirebaseAuthMultiFactorException firebaseErrorMultiFactor =
              e as FirebaseAuthMultiFactorException;
          emit(state.copyWith(
              status: SignInStatus.failure,
              errorMessage: firebaseError.code,
              multiFactorResolver: firebaseErrorMultiFactor.resolver));
        } else {
          emit(state.copyWith(
              status: SignInStatus.failure, errorMessage: firebaseError.code));
        }
      }
    });

    on<SignInWithGoogle>((event, emit) async {
      try {
        await _userRepository.signInWithGoogle();
        emit(state.copyWith(status: SignInStatus.success));
      } catch (e) {
        final FirebaseAuthException firebaseError = e as FirebaseAuthException;
        print('error is ${firebaseError.code}');
        if (firebaseError.code == "second-factor-required") {
          final FirebaseAuthMultiFactorException firebaseErrorMultiFactor =
              e as FirebaseAuthMultiFactorException;
          emit(state.copyWith(
              status: SignInStatus.failure,
              errorMessage: firebaseError.code,
              multiFactorResolver: firebaseErrorMultiFactor.resolver));
        } else {
          emit(state.copyWith(
              status: SignInStatus.failure, errorMessage: firebaseError.code));
        }
      }
    });

    on<SignInWithLine>((event, emit) async {
      emit(state.copyWith(status: SignInStatus.loading));

      try {
        await _userRepository.signInWithLine();

        emit(state.copyWith(status: SignInStatus.success));
      } catch (e) {
        print('error is ${e.toString()}');
        emit(state.copyWith(status: SignInStatus.failure));
      }
    });

    on<SignInWithAnonymously>((event, emit) async {
      emit(state.copyWith(status: SignInStatus.loading));

      try {
        await _userRepository.signInWithAnonymously();
        print('sign in with anonymously ${_userRepository.user}');
        emit(state.copyWith(status: SignInStatus.success));
      } catch (e) {
        print('error is ${e.toString()}');
        emit(state.copyWith(status: SignInStatus.failure));
      }
    });

    on<LinkingAccount>((event, emit) async {
      try {
        await _userRepository.signInWithGoogle();

        // print facebook auth from state
        print('facebook auth is ${state.facebookAuth}');
      } catch (e) {
        final FirebaseAuthException firebaseError = e as FirebaseAuthException;

        if (firebaseError.code == "second-factor-required") {
          final FirebaseAuthMultiFactorException firebaseErrorMultiFactor =
              e as FirebaseAuthMultiFactorException;
          emit(state.copyWith(
              status: SignInStatus.failure,
              errorMessage: firebaseError.code,
              multiFactorResolver: firebaseErrorMultiFactor.resolver));
        }
        emit(state.copyWith(status: SignInStatus.failure));
      }
    });

    on<SendVerificationMessage>((event, emit) async {
      try {
        final multiFactorResolver = await _userRepository
            .sendVerificationMessage(event.multiFactorResolver);

        emit(state.copyWith(
            status: SignInStatus.progress,
            verificationId: multiFactorResolver));
      } catch (e) {
        print('Error: $e');
        emit(state.copyWith(status: SignInStatus.failure));
      }
    });

    on<MultiFactorVerification>((event, emit) async {
      print('state.verificationId${state.verificationId}');
      try {
        await _userRepository.multiFactorVerification(
            state.verificationId ?? '',
            event.smsCode ?? '',
            state.multiFactorResolver);

        print('state is $state');

        if (state.facebookAuth != null) {
          await _userRepository.linkingAccount(state.facebookAuth);
        }

        emit(state.copyWith(status: SignInStatus.success));
      } catch (e) {
        print('e $e');
        emit(state.copyWith(status: SignInStatus.failure));
      }
    });

    on<EmailVerification>((event, emit) async {
      try {
        await _userRepository.sendEmailVerification();
        emit(state.copyWith(status: SignInStatus.success));
      } catch (e) {
        print('e $e');
        emit(state.copyWith(status: SignInStatus.failure));
      }
    });

    on<SignInProgress>((event, emit) async {
      emit(state.copyWith(status: SignInStatus.progress));
    });

    on<EmailVerificationSuccess>((event, emit) async {
      emit(state.copyWith(status: SignInStatus.success));
    });

    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });
  }
}
