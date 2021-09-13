import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/repository/authentication-repository.dart';

class CheckRegistrationStatusUsecase extends CompletableUseCase<void> {
  final AuthenticationRepository _repository;
  CheckRegistrationStatusUsecase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(params) async {
    final StreamController<bool> streamController = StreamController();
    try {
      bool status = await _repository.checkRegistrationStatus();
      streamController.add(status);
      streamController.close();
    } catch (error) {
      print('error in getting tags : error :  CheckRegistrationStatusUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}
