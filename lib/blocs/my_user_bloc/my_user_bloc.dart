import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instax/blocs/my_user_bloc/my_user_state.dart';
import 'package:user_repository/user_repository.dart';

part 'my_user_event.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
  final UserRepository _userRepository;

  MyUserBloc({required UserRepository myUserRepository})
      : _userRepository = myUserRepository,
        super(MyUserState()) {
    on<GetMyUser>((event, emit) async {
      try {
        final myUser = await _userRepository.getMyUser(event.myUserId);
        print('myUser $myUser');
        emit(state.copyWith(status: MyUserStatus.success, myUser: myUser));
      } catch (e) {
        print('errors : ${e.toString()}');
        emit(state.copyWith(status: MyUserStatus.failure));
      }
    });

    on<UpdateMyUser>((event, emit) async {
      try {
        await _userRepository.updateUserData(event.myUser);

        emit(
            state.copyWith(status: MyUserStatus.success, myUser: event.myUser));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(status: MyUserStatus.failure));
      }
    });
    on<GetUserData>((event, emit) async {
      try {
        final myUser = await _userRepository.getMyUser(event.myUserId);
        print('myUser $myUser');
        emit(state.copyWith(status: MyUserStatus.success, myUser: myUser));
      } catch (e) {
        print('errors : ${e.toString()}');
        emit(state.copyWith(status: MyUserStatus.failure));
      }
    });
  }
}
