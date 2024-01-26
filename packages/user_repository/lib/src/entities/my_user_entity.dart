import 'dart:ffi';

import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
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
  final String birthDate;

  const MyUserEntity({
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

  Map<String, Object?> toDocument() {
    return {
      'createdAt': createdAt,
      'disabled': disabled,
      'displayName': displayName,
      'email': email,
      'emailVerified': emailVerified,
      'lastLoginAt': lastLoginAt,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'providerDisplayName': providerDisplayName,
      'providerEmail': providerEmail,
      'providerId': providerId,
      'providerPhotoURL': providerPhotoURL,
      'providerUid': providerUid,
      'uid': uid,
      'birthDate': birthDate,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      createdAt: doc['createdAt'] as String,
      disabled: doc['disabled'] as bool,
      displayName: doc['displayName'] as String,
      email: doc['email'] as String,
      emailVerified: doc['emailVerified'] as bool,
      lastLoginAt: doc['lastLoginAt'] as String,
      phoneNumber: doc['phoneNumber'] as String,
      photoURL: doc['photoURL'] as String,
      providerDisplayName: doc['providerDisplayName'] as String,
      providerEmail: doc['providerEmail'] as String,
      providerId: doc['providerId'] as String,
      providerPhotoURL: doc['providerPhotoURL'] as String,
      providerUid: doc['providerUid'] as String,
      uid: doc['uid'] as String,
      birthDate: doc['birthDate'] as String,
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

  @override
  String toString() {
    return '''UserEntity: {
      createdAt: $createdAt,
      disabled: $disabled,
      displayName: $displayName,
      email: $email,
      emailVerified: $emailVerified,
      lastLoginAt: $lastLoginAt,
      phoneNumber: $phoneNumber,
      photoURL: $photoURL,
      providerDisplayName: $providerDisplayName,
      providerEmail: $providerEmail,
      providerId: $providerId,
      providerPhotoURL: $providerPhotoURL,
      providerUid: $providerUid,
      uid: $uid,
      birthDate: $birthDate,
    }''';
  }
}
