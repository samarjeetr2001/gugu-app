import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gugu/app/authentication/domain/repository/authentication-repository.dart';
import 'package:gugu/app/call-services/domain/entity/user-entity.dart';
import 'package:gugu/core/utility/db-keys.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String gVERIFICATIONID = "";
  UserEntity? gCURRENTUSER;
  late PhoneAuthCredential gCREDENTIAL;

  @override
  Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // await _firebaseAuth.signInWithCredential(credential);
        // _status = AuthenticationStatus.VerificationCompleted;
      },
      verificationFailed: (FirebaseAuthException error) {
        print("#########@@@@@");

        if (error.code == 'invalid-phone-number') {
          throw Exception('The provided phone number is not valid.');
        }
        print(error.message);
        throw Exception(error.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        gVERIFICATIONID = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Future<void> verifyCode({
    required String code,
  }) async {
    gCREDENTIAL = PhoneAuthProvider.credential(
        verificationId: gVERIFICATIONID, smsCode: code);
  }

  @override
  bool checkLoginStatus() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    if (gCURRENTUSER == null) {
      DocumentSnapshot userDoc = await _firebaseFirestore
          .collection(DBKeys.collectionNameUser)
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      gCURRENTUSER =
          await UserEntity.fromMap(user: userDoc.data()!, userID: userDoc.id);
    }
    return gCURRENTUSER!;
  }

  @override
  Future<void> register(
      {required String phoneNumber,
      required String name,
      required String bioMessage,
      required Uint8List profilePhoto}) async {
    UserCredential usercredentials =
        await _firebaseAuth.signInWithCredential(gCREDENTIAL);
    List<Future> futures = [
      FirebaseStorage.instance
          .ref()
          .child(usercredentials.user!.uid)
          .child("${DBKeys.keyNameProfilePhoto}.png")
          .putData(profilePhoto),
      FirebaseFirestore.instance
          .collection(DBKeys.collectionNameUser)
          .doc(usercredentials.user!.uid)
          .set({
        DBKeys.keyNameName: name,
        DBKeys.keyNameBioMessage: bioMessage,
        DBKeys.keyNamePhoneNumber: phoneNumber,
        DBKeys.keyNameProfilePhoto:
            "${usercredentials.user!.uid}/${DBKeys.keyNameProfilePhoto}.png"
      })
    ];
    await Future.wait(futures);
  }
}
