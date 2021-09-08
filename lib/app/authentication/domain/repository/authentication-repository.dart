import 'dart:typed_data';

import 'package:gugu/app/call-services/domain/entity/user-entity.dart';

abstract class AuthenticationRepository {
  Future<void> verifyPhoneNumber({required String phoneNumber});
  Future<void> verifyCode({required String code});
  bool checkLoginStatus();
  Future<UserEntity> getCurrentUser();
  Future<void> register({
    required String phoneNumber,
    required String name,
    required String bioMessage,
    required Uint8List profilePhoto,
  });
}
