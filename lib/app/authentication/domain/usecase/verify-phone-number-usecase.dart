import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/repository/authentication-repository.dart';
import 'package:gugu/core/utility/enums.dart';

class VerifyPhoneNumberUsecase extends CompletableUseCase<String> {
  final AuthenticationRepository _repository;
  VerifyPhoneNumberUsecase(this._repository);

  @override
  Future<Stream<AuthenticationStatus>> buildUseCaseStream(params) async {
    final StreamController<AuthenticationStatus> streamController =
        new StreamController();
    try {
      await _repository.verifyPhoneNumber(phoneNumber: params as String);
      streamController.close();
    } catch (error) {
      print(
          'error in verify Phone Number : $error :  VerifyPhoneNumberUsecase ');
      streamController.addError(error.toString());
    }
    return streamController.stream;
  }
}
