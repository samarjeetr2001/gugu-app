import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/call-services/domain/entity/call-entity.dart';
import 'package:gugu/app/call-services/domain/repository/call-services-repository.dart';

class MakeCallUsecase extends CompletableUseCase<CallEntity> {
  final CallServicesRepository _repository;
  MakeCallUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.makeCall(callEntity: params!);
      streamController.close();
    } catch (error) {
      print('error in make call : $error :  MakeCallUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}
