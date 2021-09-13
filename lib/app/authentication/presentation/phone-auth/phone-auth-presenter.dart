import 'dart:typed_data';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/usecase/check-registration-status-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/register-user-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/verify-code-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/verify-phone-number-usecase.dart';
import 'package:gugu/core/presentation/observer.dart';

class PhoneAuthPresenter extends Presenter {
  final VerifyPhoneNumberUsecase _verifyPhoneNumberUsecase;
  final VerifyCodeUsecase _verifyCodeUsecase;
  final RegisterUserUsecase _registerUserUsecase;
  final CheckRegistrationStatusUsecase _checkRegistrationStatusUsecase;
  PhoneAuthPresenter(this._verifyPhoneNumberUsecase, this._verifyCodeUsecase,
      this._registerUserUsecase, this._checkRegistrationStatusUsecase);

  @override
  dispose() {
    _verifyCodeUsecase.dispose();
    _verifyPhoneNumberUsecase.dispose();
    _registerUserUsecase.dispose();
    _checkRegistrationStatusUsecase.dispose();
  }

  void verifyCode({required String code, required UseCaseObserver observer}) {
    _verifyCodeUsecase.execute(observer, code);
  }

  void checkRegistrationStatus({required UseCaseObserver observer}) {
    _checkRegistrationStatusUsecase.execute(observer);
  }

  void verifyPhoneNumber(
      {required String phoneNumber, required UseCaseObserver observer}) {
    _verifyPhoneNumberUsecase.execute(observer, phoneNumber);
  }

  void registerUser(
      {required String phoneNumber,
      required String name,
      required String bioMessage,
      required Uint8List profilePhoto,
      required UseCaseObserver observer}) {
    _registerUserUsecase.execute(
        observer,
        new RegisterUserUsecaseParams(
            phoneNumber: phoneNumber,
            name: name,
            bioMessage: bioMessage,
            profilePhoto: profilePhoto));
  }
}
