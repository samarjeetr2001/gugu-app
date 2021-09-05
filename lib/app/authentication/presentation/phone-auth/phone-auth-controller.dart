import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gugu/core/presentation/observer.dart';

import '../../../../core/utility/enums.dart';
import '../../../../injection-container.dart';
import '../../../navigation-service.dart';
import 'phone-auth-presenter.dart';
import 'phone-auth-state-machine.dart';

class PhoneAuthController extends Controller {
  final PhoneAuthPresenter _presenter;
  final PhoneAuthStateMachine _stateMachine;
  final NavigationService _navigationService;
  PhoneAuthController()
      : _presenter = serviceLocator<PhoneAuthPresenter>(),
        _stateMachine = new PhoneAuthStateMachine(),
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

  PhoneAuthState getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  void verifyPhoneNumber({required String phoneNumber}) {
    _stateMachine.onEvent(new PhoneAuthLoadingEvent());
    refreshUI();
    _presenter.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      observer: new UseCaseObserver(
        () {
          print("#########@@@@@ success");

          _stateMachine.onEvent(new PhoneAuthVerifyCodeEvent());
          refreshUI();
        },
        (error) {
          print("#########@@@@@ error");

          _stateMachine.onEvent(new PhoneAuthErrorEvent());
          refreshUI();
          Fluttertoast.showToast(msg: error);
        },
      ),
    );
  }

  void verifyCode({required String code}) {
    _stateMachine.onEvent(new PhoneAuthLoadingEvent());
    refreshUI();
    _presenter.verifyCode(
      code: code,
      observer: new UseCaseObserver(
        () {
          _navigationService.navigateTo(NavigationService.homeRoute,
              shouldReplace: true);
        },
        (error) {
          _stateMachine.onEvent(new PhoneAuthErrorEvent());
          refreshUI();
          Fluttertoast.showToast(msg: error.toString());
        },
      ),
    );
  }

  void changePhoneNumber() {
    _stateMachine.onEvent(new PhoneAuthChangePhoneNumberEvent());
    refreshUI();
  }
}
