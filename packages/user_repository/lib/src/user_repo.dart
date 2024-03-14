import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import '../user_repository.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<void> signIn(String email, String password);

  Future<void> signInWithFacebook();

  Future<void> linkingAccount(AuthCredential? facebookAuth);

  Future<void> signInWithGoogle();

  Future<void> signInWithLine();

  Future<void> signInWithAnonymously();

  Future<String> phonVerify(String phoneNumber);

  Future<void> verifyOTP(
      String phoneNumber, String verificationId, String smsCode);

  Future<String> sendVerificationMessage(
      MultiFactorResolver? multiFactorResolver);

  Future<void> multiFactorVerification(String verificationId, String smsCode,
      MultiFactorResolver? multiFactorResolver);

  Future<void> logOut();

  Future<void> sendEmailVerification();

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> resetPassword(String email);

  Future<void> setUserData(MyUser user);

  Future<void> updateUserData(MyUser user);

  Future<MyUser> getMyUser(String myUserId);

  Future<void> uploadPicture(File imageFile, String? userId);

  Future<void> onlineStateChange(bool isOnline);

  Future<void> inChatStateChange(bool isOnline);
}
