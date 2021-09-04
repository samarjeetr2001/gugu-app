import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/repository/authentication-repository.dart';

class VerifyCodeUsecase extends CompletableUseCase<String> {
  final AuthenticationRepository _repository;
  VerifyCodeUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.verifyCode(code: params as String);
    } catch (error) {
      print('error in getting tags : $error :  VerifyCodeUsecase ');
      streamController.addError(error.toString());
    }
    streamController.close();
    return streamController.stream;
  }
}
