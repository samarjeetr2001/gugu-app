import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/repository/authentication-repository.dart';
import 'package:gugu/app/call-services/domain/entity/user-entity.dart';

class GetCurrentUserUsecase extends CompletableUseCase<void> {
  final AuthenticationRepository _repository;
  GetCurrentUserUsecase(this._repository);

  @override
  Future<Stream<UserEntity>> buildUseCaseStream(params) async {
    final StreamController<UserEntity> streamController = StreamController();
    try {
      UserEntity user = await _repository.getCurrentUser();
      streamController.add(user);
      streamController.close();
    } catch (error) {
      print('error in getting current user : $error :  GetCurrentUserUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}
