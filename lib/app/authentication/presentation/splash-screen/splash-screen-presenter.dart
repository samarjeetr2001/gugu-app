import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/domain/usecase/check-login-status-usecase.dart';
import 'package:gugu/core/presentation/observer.dart';

class SplashScreenPresenter extends Presenter {
  final CheckLoginStatusUsecase _checkLoginStatusUsecase;
  SplashScreenPresenter(this._checkLoginStatusUsecase);

  @override
  dispose() {
    _checkLoginStatusUsecase.dispose();
  }

  void checkLoginStatus({required UseCaseObserver observer}) {
    _checkLoginStatusUsecase.execute(observer);
  }
}
