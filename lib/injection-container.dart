import 'package:get_it/get_it.dart';
import 'package:gugu/app/authentication/domain/usecase/check-login-status-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/check-registration-status-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/get-current-user-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/register-user-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/verify-code-usecase.dart';
import 'package:gugu/app/authentication/domain/usecase/verify-phone-number-usecase.dart';
import 'package:gugu/app/authentication/presentation/phone-auth/phone-auth-presenter.dart';
import 'package:gugu/app/authentication/presentation/splash-screen/splash-screen-presenter.dart';
import 'package:gugu/app/call-services/data/call-services-repository-impl.dart';
import 'package:gugu/app/call-services/domain/repository/call-services-repository.dart';
import 'package:gugu/app/call-services/domain/usecase/end-call-usecase.dart';
import 'package:gugu/app/call-services/domain/usecase/get-call-listener-usecase.dart';
import 'package:gugu/app/call-services/domain/usecase/make-call-usecase.dart';

import 'app/authentication/data/authentication-repository-impl.dart';
import 'app/authentication/domain/repository/authentication-repository.dart';
import 'app/navigation-service.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //Navigation
  serviceLocator.registerLazySingleton(() => NavigationService());
  //
  // authentication
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => (AuthenticationRepositoryImpl()));
  serviceLocator
      .registerFactory(() => VerifyPhoneNumberUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => VerifyCodeUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => RegisterUserUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetCurrentUserUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => CheckLoginStatusUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => CheckRegistrationStatusUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => PhoneAuthPresenter(
      serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => SplashScreenPresenter(serviceLocator()));
  //
  //call service
  serviceLocator.registerLazySingleton<CallServicesRepository>(
      () => (CallServieRepositoryImpl()));
  serviceLocator.registerFactory(() => MakeCallUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => EndCallUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetCallListenerUsecase(serviceLocator()));
}

Future<void> reset() async {
  serviceLocator.resetLazySingleton<AuthenticationRepository>();
}
