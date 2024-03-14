import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  final String? createdAt;
  final bool? disabled;
  final String? displayName;
  final String? email;
  final bool? emailVerified;
  final String? lastLoginAt;
  final String? phoneNumber;
  final String? photoURL;
  final String? providerDisplayName;
  final String? providerEmail;
  final String? providerId;
  final String? providerPhotoURL;
  final String? providerUid;
  final String? uid;
  final String? birthDate;
  final String? gender;
  final List? jobPostSelected;

  MyUser({
    this.createdAt,
    this.disabled,
    this.displayName,
    this.email,
    this.emailVerified,
    this.lastLoginAt,
    this.phoneNumber,
    this.photoURL,
    this.providerDisplayName,
    this.providerEmail,
    this.providerId,
    this.providerPhotoURL,
    this.providerUid,
    this.uid,
    this.birthDate,
    this.gender,
    this.jobPostSelected = const [],
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
    gender: '',
    jobPostSelected: const [],
  );

  /// Modify MyUser parameters
  MyUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? gender,
    String? phoneNumber,
    String? birthDate,
    jobPostSelected,
  }) {
    return MyUser(
      createdAt: createdAt,
      disabled: disabled,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      emailVerified: emailVerified,
      lastLoginAt: lastLoginAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL,
      providerDisplayName: providerDisplayName,
      providerEmail: providerEmail,
      providerId: providerId,
      providerPhotoURL: providerPhotoURL,
      providerUid: providerUid,
      uid: uid ?? this.uid,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      jobPostSelected: jobPostSelected ?? this.jobPostSelected,
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
        gender: gender,
        jobPostSelected: const {});
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
      gender: entity.gender,
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
        gender,
      ];
}

class AnonymousUser {
  final String uid;
  final String? displayName;
  final String? email;
  final bool isEmailVerified;
  final bool isAnonymous;
  final DateTime creationTime;
  final DateTime lastSignInTime;
  final String? phoneNumber;
  final String? photoURL;
  final List<UserProviderData> providerData;
  final String refreshToken;

  AnonymousUser({
    required this.uid,
    this.displayName,
    this.email,
    required this.isEmailVerified,
    required this.isAnonymous,
    required this.creationTime,
    required this.lastSignInTime,
    this.phoneNumber,
    this.photoURL,
    required this.providerData,
    required this.refreshToken,
  });

  factory AnonymousUser.fromMap(Map<String, dynamic> map) {
    return AnonymousUser(
      uid: map['uid'],
      displayName: map['displayName'],
      email: map['email'],
      isEmailVerified: map['isEmailVerified'],
      isAnonymous: map['isAnonymous'],
      creationTime: DateTime.parse(map['creationTime']),
      lastSignInTime: DateTime.parse(map['lastSignInTime']),
      phoneNumber: map['phoneNumber'],
      photoURL: map['photoURL'],
      providerData: List<UserProviderData>.from(map['providerData'].map(
        (data) => UserProviderData.fromMap(data),
      )),
      refreshToken: map['refreshToken'],
    );
  }
}

class UserProviderData {
  final String providerId;
  final String uid;

  UserProviderData({
    required this.providerId,
    required this.uid,
  });

  factory UserProviderData.fromMap(Map<String, dynamic> map) {
    return UserProviderData(
      providerId: map['providerId'],
      uid: map['uid'],
    );
  }
}
