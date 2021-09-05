import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/repository/authentication-repository.dart';

class CheckLoginStatusUsecase extends CompletableUseCase<void> {
  final AuthenticationRepository _repository;
  CheckLoginStatusUsecase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(params) async {
    final StreamController<bool> streamController = StreamController();
    try {
      bool status = _repository.checkLoginStatus();
      streamController.add(status);
      streamController.close();
    } catch (error) {
      print('error in getting tags : error :  CheckLoginStstusUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}
