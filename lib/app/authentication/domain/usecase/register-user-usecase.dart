import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/repository/authentication-repository.dart';

class RegisterUserUsecase
    extends CompletableUseCase<RegisterUserUsecaseParams> {
  final AuthenticationRepository _repository;
  RegisterUserUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.register(
        phoneNumber: params!.phoneNumber,
        name: params.name,
        bioMessage: params.bioMessage,
        profilePhoto: params.profilePhoto,
      );
      streamController.close();
    } catch (error) {
      print('error in getting tags : error :  RegisterUserUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}

class RegisterUserUsecaseParams {
  final String phoneNumber;
  final String name;
  final String bioMessage;
  final Uint8List profilePhoto;
  RegisterUserUsecaseParams({
    required this.phoneNumber,
    required this.name,
    required this.bioMessage,
    required this.profilePhoto,
  });
}
