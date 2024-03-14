import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// ignore: library_prefixes
import 'package:flutter_line_sdk/flutter_line_sdk.dart' as LineSDK;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/src/models/my_user.dart';

import 'entities/entities.dart';
import 'user_repo.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final database = FirebaseDatabase.instance.reference();

  /// Stream of [MyUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [MyUser.empty] if the user is not authenticated.
  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email as String, password: password);

      myUser = myUser.copyWith(uid: user.user!.uid);

      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> linkingAccount(AuthCredential? facebookAuth) async {
    print('facebookAuth ${facebookAuth}');

    // get current user
    final currentUser = FirebaseAuth.instance.currentUser;

    print('currentUser ${currentUser}');
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(facebookAuth!);

      print('userCredentials ${userCredential}');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;

        // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    print('signInWithGoogle');
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Error: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> signInWithLine() async {
    try {
      final result = await LineSDK.LineSDK.instance.login(
        scopes: ['profile', 'openid', 'email'],
      );

      verifyToken(result.accessToken.value, result.userProfile?.data,
          result.accessToken.email);
    } catch (e) {
      print("Error: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> signInWithAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();

      print('userCredential ${userCredential.user}');

      // save the user credentials to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // set the user data to shared preferences
      await prefs.setString(
          'anonymousUserData', jsonEncode(userCredential.user!).toString());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await usersCollection.doc(user.uid).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      final userData = await usersCollection.doc(myUserId).get();

      if (!userData.exists) {
        return MyUser.empty;
      }

      return MyUser.fromEntity(MyUserEntity.fromDocument(userData.data()!));
    } catch (e) {
      print('error ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> uploadPicture(File imageFile, String? userId) async {
    try {
      String fileName =
          '$userId-${DateTime.now().millisecondsSinceEpoch.toString()}';
      Reference reference =
          FirebaseStorage.instance.ref().child('users/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
        print('URL Is $downloadUrl');

        return downloadUrl;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Future<void> updateUserData(MyUser user) async {
    try {
      print('user: $user');
      await usersCollection.doc(user.uid).update(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // verify token with api
  Future<void> verifyToken(
      String token, dynamic userProfile, String? email) async {
    print('email: $email');
    // try {
    final url = Uri.parse(
        'https://us-central1-plawarn-6704c.cloudfunctions.net/createCustomToken');

    final Map<String, dynamic> requestBody = {
      "accessToken": token,
      "name": "${userProfile['displayName']}",
      "email": email,
      "picture": "${userProfile['pictureUrl']}",
      "id": "${userProfile['userId']}",
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // create custom token
        final Map<String, dynamic> responseMap = jsonDecode(response.body);

        final customToken = responseMap['customToken'];

        print('Custom Token: $customToken');

        // sign in with custom token
        final userCredential =
            await FirebaseAuth.instance.signInWithCustomToken(customToken);

        if (userCredential.user != null) {
          // get user data from Firebase with uid
          final user =
              await usersCollection.doc(userCredential.user!.uid).get();

          if (!user.exists) {
            // set new user data for the user
            await setUserData(MyUser(
              uid: userCredential.user!.uid,
              email: email,
              displayName: userProfile['displayName'],
              photoURL: userProfile['pictureUrl'],
              phoneNumber: userProfile['statusMessage'],
              providerId: 'line',
            ));
          } else {
            print('User already exists');
          }
        }
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
        // Handle error
      }
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  @override
  Future<String> sendVerificationMessage(
    MultiFactorResolver? multiFactorResolver,
  ) async {
    try {
      Completer<String> verificationIdCompleter = Completer<String>();

      if (multiFactorResolver == null || multiFactorResolver.hints.isEmpty) {
        // Handle the case where multiFactorResolver or hints are null or empty
        print('No hints available');
        return '';
      }

      final session = multiFactorResolver.session;

      // Check if the first hint is not null before casting
      final hint = multiFactorResolver.hints.first;
      if (hint is! PhoneMultiFactorInfo) {
        return '';
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        multiFactorSession: session,
        multiFactorInfo: hint,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async {
          print('verificationId: $verificationId');
          // Complete the completer with the verificationId
          verificationIdCompleter.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (_) {},
      );
      return await verificationIdCompleter.future;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> multiFactorVerification(String verificationId, String smsCode,
      MultiFactorResolver? multiFactorResolver) async {
    print('verificationId: $verificationId');
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      print('credential: $credential');

      await multiFactorResolver!.resolveSignIn(
        PhoneMultiFactorGenerator.getAssertion(
          credential,
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e; // Rethrow the exception after handling it
    }
  }

  // get firebase account
  Future<void> getFirebaseUser(String userId) async {
    try {
      final firebaseUid = 'line:$userId';

      final user = await usersCollection.doc(firebaseUid).get();

      if (!user.exists) {
        print('User not found');
      }

      print('User found');
    } catch (e) {
      log("error is : ${e.toString()}");
      rethrow;
    }
  }

  Future<void> createNewUserOnFirestore(String userId, String clientId) async {
    try {
      // Reference to the users collection in Firestore
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Check if the user already exists
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
      if (!userSnapshot.exists) {
        // User does not exist, create a new user document
        await usersCollection.doc(userId).set({
          'userId': userId,
          'clientId': clientId,
          // Add other user properties as needed
        });

        print('User created on Firestore: $userId');
      } else {
        // User already exists
        print('User already exists on Firestore: $userId');
      }
    } catch (e) {
      print('Error creating user on Firestore: $e');
      // Handle the error as needed
    }
  }

  @override
  Future<String> phonVerify(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    Completer<String> verificationIdCompleter = Completer<String>();

    try {
      await auth.verifyPhoneNumber(
        // multiFactorInfo: session as MultiFactorInfo,
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          // Complete the completer with the verificationId
          verificationIdCompleter.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      // Wait for the completer to be completed and return the verificationId
      return await verificationIdCompleter.future;
    } catch (e) {
      print('error is ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      print('error is ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> verifyOTP(
      String phoneNumber, String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      //enrollment
      final multiFactorAssertion =
          PhoneMultiFactorGenerator.getAssertion(credential);

      await FirebaseAuth.instance.currentUser!.multiFactor
          .enroll(multiFactorAssertion);

      // set phone number to user data
      await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      print('error is ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> onlineStateChange(bool isOnline) async {
    try {
      if (!isOnline) {
        await database.child('users/${_firebaseAuth.currentUser!.uid}').update({
          'inApp': isOnline,
          'inChat': isOnline,
        });
      } else {
        await database.child('users/${_firebaseAuth.currentUser!.uid}').update({
          'inApp': isOnline,
        });
      }
    } catch (e) {
      print('error is ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> inChatStateChange(bool isOnline) async {
    try {
      log('inChatStateChange');
      await database.child('users/${_firebaseAuth.currentUser!.uid}').update({
        'inChat': isOnline,
      });
    } catch (e) {
      print('error is ${e.toString()}');
      rethrow;
    }
  }
}
