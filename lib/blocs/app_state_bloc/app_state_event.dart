part of 'app_state_bloc.dart';

abstract class AppLifecycleEvent extends Equatable {
  const AppLifecycleEvent();
}

class UpdateAppLifecycleState extends AppLifecycleEvent {
  final AppLifecycleState? newState;

  const UpdateAppLifecycleState(this.newState);

  @override
  List<Object?> get props => [newState];
}

class IsLoading extends AppLifecycleEvent {
  final bool isLoading;
  const IsLoading({required this.isLoading});

  @override
  List<Object?> get props => [];
}

class InChatStateChange extends AppLifecycleEvent {
  final bool isOnline;
  const InChatStateChange({required this.isOnline});

  @override
  List<Object?> get props => [];
}
