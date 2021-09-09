import 'package:flutter/foundation.dart';
import 'package:gugu/app/call-services/domain/entity/media-entity.dart';
import 'package:gugu/core/utility/db-keys.dart';
import 'package:gugu/core/utility/enums.dart';

import 'user-entity.dart';

class CallEntity {
  final String id;
  final CallType type;
  final bool? isReceiver;
  final UserEntity receiver;
  final UserEntity dialer;

  CallEntity({
    required this.id,
    required this.type,
    required this.isReceiver,
    required this.receiver,
    required this.dialer,
  });

  static Future<CallEntity> fromMap(
      {required Map<String, dynamic> data, required bool isReceiver}) async {
    Map<String, dynamic> receiver = {
      DBKeys.keyNameName: data[DBKeys.keyNameReceiverName],
      DBKeys.keyNamePhoneNumber: data[DBKeys.keyNameReceiverPhoneNumber],
      DBKeys.keyNameProfilePhoto: data[DBKeys.keyNameReceiverProfilePhoto],
    };
    Map<String, dynamic> dailer = {
      DBKeys.keyNameName: data[DBKeys.keyNameDialerName],
      DBKeys.keyNamePhoneNumber: data[DBKeys.keyNameDialerPhoneNumber],
      DBKeys.keyNameProfilePhoto: data[DBKeys.keyNameDialerProfilePhoto],
    };
    List<Future<UserEntity>> futures = [
      UserEntity.fromMap(
        user: receiver,
        userID: data[DBKeys.keyNameReceiverID],
      ),
      UserEntity.fromMap(
        user: dailer,
        userID: data[DBKeys.keyNameDialerID],
      ),
    ];
    await Future.wait(futures).then(
      (value) {
        return new CallEntity(
          id: data[DBKeys.keyNameCallID],
          type: data[DBKeys.keyNameType],
          isReceiver: isReceiver,
          receiver: value.first,
          dialer: value.last,
        );
      },
    );
    throw Exception("CallEntity : toMap Error");
  }

  static Map<String, dynamic> toMap({required CallEntity callEntity}) {
    return {
      DBKeys.keyNameCallID: callEntity.id,
      DBKeys.keyNameDialerID: callEntity.dialer.id,
      DBKeys.keyNameDialerName: callEntity.dialer.name,
      DBKeys.keyNameDialerProfilePhoto:
          (callEntity.dialer.profilePhoto as ImageMediaEntity).path,
      DBKeys.keyNameReceiverID: callEntity.receiver.id,
      DBKeys.keyNameReceiverName: callEntity.receiver.name,
      DBKeys.keyNameReceiverProfilePhoto:
          (callEntity.receiver.profilePhoto as ImageMediaEntity).path,
      DBKeys.keyNameType: describeEnum(callEntity.type),
    };
  }
}
