import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/call-services/domain/repository/call-services-repository.dart';
import 'package:gugu/core/utility/enums.dart';

class ConnectCallUsecase extends CompletableUseCase<ConnectCallUsecaseParam> {
  final CallServicesRepository _repository;
  ConnectCallUsecase(this._repository);

  @override
  Future<Stream<CallStatus>> buildUseCaseStream(params) async {
    return await _repository.connectCall(
        userID: params!.userID,
        callID: params.callID,
        callType: params.callType);
  }
}

class ConnectCallUsecaseParam {
  final String callID;
  final String userID;
  final CallType callType;

  ConnectCallUsecaseParam(
      {required this.callID, required this.userID, required this.callType});
}
