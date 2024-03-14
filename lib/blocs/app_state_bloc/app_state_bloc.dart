import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

part 'app_state_event.dart';
part 'app_state_state.dart';

class AppStateBloc extends Bloc<AppLifecycleEvent, AppState> {
  final UserRepository _userRepository;

  AppStateBloc(this._userRepository) : super(const AppState()) {
    on<UpdateAppLifecycleState>((event, emit) async {
      final appStateStatus =
          _mapAppLifecycleStateToAppStateStatus(event.newState);

      if (AppStateStatus.resumed == appStateStatus) {
        await _userRepository.onlineStateChange(true);
      } else {
        await _userRepository.onlineStateChange(false);
      }

      emit(state.copyWith(state: appStateStatus));
    });
    on<IsLoading>((event, emit) {
      emit(state.copyWith(isLoading: !state.isLoading));
    });
    on<InChatStateChange>((event, emit) async {
      await _userRepository.inChatStateChange(event.isOnline);
    });
  }

  AppStateStatus _mapAppLifecycleStateToAppStateStatus(
      AppLifecycleState? appLifecycleState) {
    if (appLifecycleState == null) {
      return AppStateStatus
          .resumed; // Default to resumed if appLifecycleState is null
    }

    switch (appLifecycleState) {
      case AppLifecycleState.resumed:
        return AppStateStatus.resumed;
      case AppLifecycleState.inactive:
        return AppStateStatus.inactive;
      case AppLifecycleState.paused:
        return AppStateStatus.paused;
      case AppLifecycleState.detached:
        return AppStateStatus.detached;
      default:
        return AppStateStatus.resumed; // Default to resumed if unknown state
    }
  }
}
