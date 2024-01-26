import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import '../user_repository.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<void> signIn(String email, String password);

  Future<void> signInWithFacebook();

  Future<void> logOut();

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> resetPassword(String email);

  Future<void> setUserData(MyUser user);

  Future<void> updateUserData(MyUser user);

  Future<MyUser> getMyUser(String myUserId);

  Future<void> uploadPicture(File imageFile, String userId);
}
