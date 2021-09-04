import 'package:firebase_auth/firebase_auth.dart';
import 'package:gugu/app/authentication/domain/repository/authentication-repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String gVERIFICATIONID = "";

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
  Future<void> verifyCode({required String code}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: gVERIFICATIONID, smsCode: code);
    await _firebaseAuth.signInWithCredential(credential);
  }
}
