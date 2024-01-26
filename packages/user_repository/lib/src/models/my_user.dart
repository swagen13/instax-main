import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  final String createdAt;
  final bool disabled;
  final String displayName;
  final String email;
  final bool emailVerified;
  final String lastLoginAt;
  final String phoneNumber;
  final String photoURL;
  final String providerDisplayName;
  final String providerEmail;
  final String providerId;
  final String providerPhotoURL;
  final String providerUid;
  final String uid;
  late final String birthDate;

  MyUser({
    required this.createdAt,
    required this.disabled,
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.lastLoginAt,
    required this.phoneNumber,
    required this.photoURL,
    required this.providerDisplayName,
    required this.providerEmail,
    required this.providerId,
    required this.providerPhotoURL,
    required this.providerUid,
    required this.uid,
    required this.birthDate,
  });

  /// Empty user which represents an unauthenticated user.
  static final empty = MyUser(
    createdAt: '',
    disabled: false,
    displayName: '',
    email: '',
    emailVerified: false,
    lastLoginAt: '',
    phoneNumber: '',
    photoURL: '',
    providerDisplayName: '',
    providerEmail: '',
    providerId: '',
    providerPhotoURL: '',
    providerUid: '',
    uid: '',
    birthDate: '',
  );

  /// Modify MyUser parameters
  MyUser copyWith({String? uid, String? email, String? displayName}) {
    return MyUser(
      createdAt: createdAt,
      disabled: disabled,
      displayName: displayName ?? "",
      email: email ?? "",
      emailVerified: emailVerified,
      lastLoginAt: lastLoginAt,
      phoneNumber: phoneNumber,
      photoURL: photoURL,
      providerDisplayName: providerDisplayName,
      providerEmail: providerEmail,
      providerId: providerId,
      providerPhotoURL: providerPhotoURL,
      providerUid: providerUid,
      uid: uid ?? this.uid,
      birthDate: birthDate,
    );
  }

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      createdAt: createdAt,
      disabled: disabled,
      displayName: displayName,
      email: email,
      emailVerified: emailVerified,
      lastLoginAt: lastLoginAt,
      phoneNumber: phoneNumber,
      photoURL: photoURL,
      providerDisplayName: providerDisplayName,
      providerEmail: providerEmail,
      providerId: providerId,
      providerPhotoURL: providerPhotoURL,
      providerUid: providerUid,
      uid: uid,
      birthDate: birthDate,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      createdAt: entity.createdAt,
      disabled: entity.disabled,
      displayName: entity.displayName,
      email: entity.email,
      emailVerified: entity.emailVerified,
      lastLoginAt: entity.lastLoginAt,
      phoneNumber: entity.phoneNumber,
      photoURL: entity.photoURL,
      providerDisplayName: entity.providerDisplayName,
      providerEmail: entity.providerEmail,
      providerId: entity.providerId,
      providerPhotoURL: entity.providerPhotoURL,
      providerUid: entity.providerUid,
      uid: entity.uid,
      birthDate: entity.birthDate,
    );
  }

  @override
  List<Object?> get props => [
        createdAt,
        disabled,
        displayName,
        email,
        emailVerified,
        lastLoginAt,
        phoneNumber,
        photoURL,
        providerDisplayName,
        providerEmail,
        providerId,
        providerPhotoURL,
        providerUid,
        uid,
        birthDate,
      ];
}
