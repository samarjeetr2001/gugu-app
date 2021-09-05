import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/authentication/presentation/splash-screen/splash-screen-presenter.dart';
import 'package:gugu/core/presentation/observer.dart';

import '../../../../injection-container.dart';
import '../../../navigation-service.dart';

class SplashScreenController extends Controller {
  final SplashScreenPresenter _presenter;
  final NavigationService _navigationService;
  SplashScreenController()
      : _presenter = serviceLocator<SplashScreenPresenter>(),
        _navigationService = serviceLocator<NavigationService>(),
        super();

  @override
  void initListeners() {}

  @override
  void onInitState() {
    super.onInitState();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void checkLoginStatus() {
    _presenter.checkLoginStatus(
      observer: new UseCaseObserver(
        () {},
        (error) {
          _navigationService.navigateTo(NavigationService.loginRoute,
              shouldReplace: true);
        },
        onNextFunc: (bool status) {
          if (status) {
            _navigationService.navigateTo(NavigationService.homeRoute,
                shouldReplace: true);
          } else {
            _navigationService.navigateTo(NavigationService.loginRoute,
                shouldReplace: true);
          }
        },
      ),
    );
  }
}
