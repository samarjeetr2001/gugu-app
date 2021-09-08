import 'package:gugu/core/utility/enums.dart';

import 'user-entity.dart';

class CallEntity {
  final String id;
  final CallType type;
  final bool isReceiver;
  final UserEntity receiver;
  final UserEntity dialer;

  CallEntity({
    required this.id,
    required this.type,
    required this.isReceiver,
    required this.receiver,
    required this.dialer,
  });
}
