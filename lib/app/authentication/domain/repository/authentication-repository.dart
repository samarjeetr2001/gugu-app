
abstract class AuthenticationRepository {
  Future<void> verifyPhoneNumber({required String phoneNumber});
  Future<void> verifyCode({required String code});
}
