import 'package:gugu/app/call-services/domain/entity/call-entity.dart';
import 'package:gugu/core/utility/enums.dart';

abstract class CallServicesRepository {
  Future<Stream<CallEntity>> getCallListener();
  Future<void> makeCall({required CallEntity callEntity});
  Future<void> endCall({required String userID});
  Future<Stream<CallStatus>> connectCall(
      {required String userID,
      required String callID,
      required CallType callType});
}
