import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

enum MyUserStatus { initial, success, loading, failure }

class MyUserState extends Equatable {
  final MyUserStatus status;
  final MyUser myUser;

  // Define a constant instance of MyUser
  static MyUser _emptyMyUser = MyUser.empty;

  MyUserState({
    this.status = MyUserStatus.initial,
    MyUser? myUser,
  }) : myUser = myUser ?? _emptyMyUser;

  MyUserState copyWith({
    MyUserStatus? status,
    MyUser? myUser,
  }) {
    return MyUserState(
      status: status ?? this.status,
      myUser: myUser ?? this.myUser,
    );
  }

  @override
  List<Object> get props => [status, myUser];
}
