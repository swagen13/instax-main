import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
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
  final Map<String, dynamic> jobPostSelected;

  const MyUserEntity({
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
    this.jobPostSelected = const {},
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
      'gender': gender,
      'jobPostSelected': jobPostSelected,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      createdAt: doc['createdAt'] as String?,
      disabled: doc['disabled'] as bool?,
      displayName: doc['displayName'] as String?,
      email: doc['email'] as String?,
      emailVerified: doc['emailVerified'] as bool?,
      lastLoginAt: doc['lastLoginAt'] as String?,
      phoneNumber: doc['phoneNumber'] as String?,
      photoURL: doc['photoURL'] as String?,
      providerDisplayName: doc['providerDisplayName'] as String?,
      providerEmail: doc['providerEmail'] as String?,
      providerId: doc['providerId'] as String?,
      providerPhotoURL: doc['providerPhotoURL'] as String?,
      providerUid: doc['providerUid'] as String?,
      uid: doc['uid'] as String?,
      birthDate: doc['birthDate'] as String,
      gender: doc['gender'] as String,
      jobPostSelected: doc['jobPostSelected'] as Map<String, dynamic>,
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
        jobPostSelected
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
      gender: $gender,
      jobPostSelected: $jobPostSelected
    }''';
  }
}

class JobPostEntity {
  String id;
  String description1;
  String description2;
  String subJob;
  String position;
  String wage;
  bool isSelected;

  JobPostEntity({
    required this.id,
    required this.description1,
    required this.description2,
    required this.subJob,
    required this.position,
    required this.wage,
    this.isSelected = false,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'description1': description1,
      'description2': description2,
      'subJob': subJob,
      'position': position,
      'wage': wage,
      'isSelected': isSelected,
    };
  }

  static JobPostEntity fromDocument(Map<String, dynamic> doc) {
    return JobPostEntity(
      id: doc['id'] as String,
      description1: doc['description1'] as String,
      description2: doc['description2'] as String,
      subJob: doc['subJob'] as String,
      position: doc['position'] as String,
      wage: doc['wage'] as String,
      isSelected: doc['isSelected'] as bool,
    );
  }

  List<Object?> get props =>
      [id, description1, description2, subJob, position, wage, isSelected];

  @override
  String toString() {
    return '''JobPostEntity: {
      id: $id
      description1: $description1
      description2: $description2
      subJob: $subJob
      position: $position
      wage: $wage
      isSelected: $isSelected
    }''';
  }
}
