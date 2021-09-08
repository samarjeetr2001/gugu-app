import 'package:gugu/app/call-services/domain/entity/call-entity.dart';
import 'package:gugu/app/call-services/domain/repository/call-services-repository.dart';

class CallServieRepositoryImpl extends CallServicesRepository{
  @override
  Future<void> endCall({required String userID}) {
    // TODO: implement endCall
    throw UnimplementedError();
  }

  @override
  Future<void> makeCall({required CallEntity callEntity}) {
    // TODO: implement makeCall
    throw UnimplementedError();
  }
}