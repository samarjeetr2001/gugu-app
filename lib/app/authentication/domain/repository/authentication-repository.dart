import 'package:gugu/app/call-services/domain/entity/user-entity.dart';

abstract class AuthenticationRepository {
  Future<void> verifyPhoneNumber({required String phoneNumber});
  Future<void> verifyCode({required String code});
  bool checkLoginStatus();
  Future<UserEntity> getCurrentUser();
}
