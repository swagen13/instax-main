import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  String? gender;
  String? picture;
  String? birthDate;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    this.picture,
    this.birthDate,
  });

  /// Empty user which represents an unauthenticated user.
  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    picture: '',
    gender: '',
    birthDate: '',
  );

  /// Modify MyUser parameters
  MyUser copyWith(
      {String? id,
      String? email,
      String? name,
      String? picture,
      String? gender,
      String? birthDate}) {
    return MyUser(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        picture: picture ?? this.picture,
        gender: gender ?? this.gender,
        birthDate: birthDate ?? this.birthDate);
  }

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
        id: id,
        email: email,
        name: name,
        picture: picture,
        gender: gender,
        birthDate: birthDate);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
      gender: entity.gender,
      birthDate: entity.birthDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        picture,
        gender,
        birthDate,
      ];
}
