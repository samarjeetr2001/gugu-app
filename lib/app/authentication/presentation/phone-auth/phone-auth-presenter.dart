import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/usecase/verify-code-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/verify-phone-number-usecase.dart';
import 'package:gugu/core/presentation/observer.dart';

class PhoneAuthPresenter extends Presenter {
  final VerifyPhoneNumberUsecase _verifyPhoneNumberUsecase;
  final VerifyCodeUsecase _verifyCodeUsecase;
  PhoneAuthPresenter(this._verifyPhoneNumberUsecase, this._verifyCodeUsecase);

  @override
  dispose() {
    _verifyCodeUsecase.dispose();
    _verifyPhoneNumberUsecase.dispose();
  }

  void verifyCode({required String code, required UseCaseObserver observer}) {
    _verifyCodeUsecase.execute(observer, code);
  }

  void verifyPhoneNumber(
      {required String phoneNumber, required UseCaseObserver observer}) {
    _verifyPhoneNumberUsecase.execute(observer, phoneNumber);
  }
}
