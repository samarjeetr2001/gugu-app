import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/call-services/domain/repository/call-services-repository.dart';

class EndCallUsecase extends CompletableUseCase<String> {
  final CallServicesRepository _repository;
  EndCallUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.endCall(userID: params!);
      streamController.close();
    } catch (error) {
      print('error in end call : $error :  EndCallUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}
