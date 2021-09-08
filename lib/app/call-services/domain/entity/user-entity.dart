import 'package:gugu/app/call-services/domain/entity/media-entity.dart';
import 'package:gugu/core/utility/db-keys.dart';

class UserEntity {
  final String id;
  final String name;
  final String bioMessage;
  final String phoneNumber;
  final MediaEntity profilePhoto;

  UserEntity({
    required this.id,
    required this.name,
    required this.bioMessage,
    required this.phoneNumber,
    required this.profilePhoto,
  });

  static Future<UserEntity> fromMap(
      {required Map<String, dynamic> user, required String userID}) async {
    return new UserEntity(
      id: userID,
      name: user[DBKeys.keyNameName],
      bioMessage: user[DBKeys.keyNameBioMessage],
      phoneNumber: user[DBKeys.keyNamePhoneNumber],
      profilePhoto: await ImageMediaEntity.fromMap(
          path: user[DBKeys.keyNameProfilePhoto]),
    );
  }
}
