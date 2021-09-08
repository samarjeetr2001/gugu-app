import 'package:gugu/app/call-services/domain/entity/call-entity.dart';

abstract class CallServicesRepository {
  Future<void> makeCall({required CallEntity callEntity});
  Future<void> endCall({required String userID});
}
