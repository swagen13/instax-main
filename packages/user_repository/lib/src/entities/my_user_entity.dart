import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;
  final String? gender;
  final String? birthDate;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    this.gender,
    this.birthDate,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'picture': picture,
      'gender': gender,
      'birthDate': birthDate,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
        id: doc['id'] as String,
        email: doc['email'] as String,
        name: doc['name'] as String,
        picture: doc['picture'] as String?,
        gender: doc['gender'] as String,
        birthDate: doc['birthDate'] as String);
  }

  @override
  List<Object?> get props => [id, email, name, picture, gender, birthDate];

  @override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      name: $name
      picture: $picture
      gender: $gender
      birthDate: $birthDate
    }''';
  }
}
