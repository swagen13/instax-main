part of 'app_state_bloc.dart';

enum AppStateStatus { resumed, inactive, paused, detached }

class AppState extends Equatable {
  final AppStateStatus state;
  final bool isLoading;

  const AppState({
    this.state = AppStateStatus.resumed,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [state, isLoading];

  AppState copyWith({
    AppStateStatus? state,
    bool? isLoading,
  }) {
    return AppState(
      state: state ?? this.state,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
