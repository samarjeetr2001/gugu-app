import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/call-services/domain/entity/call-entity.dart';
import 'package:gugu/app/call-services/domain/repository/call-services-repository.dart';

class GetCallListenerUsecase extends CompletableUseCase<void> {
  final CallServicesRepository _repository;
  GetCallListenerUsecase(this._repository);

  @override
  Future<Stream<CallEntity>> buildUseCaseStream(params) async {
    return _repository.getCallListener();
  }
}
