import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../injection-container.dart';
import '../../navigation-service.dart';
import 'home-presenter.dart';
import 'home-state-machine.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;
  final HomeStateMachine _stateMachine;
  final NavigationService _navigationService;
  HomeController()
      : _presenter = serviceLocator<HomePresenter>(),
        _stateMachine = new HomeStateMachine(),
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

  HomeState getCurrentState() {
    return _stateMachine.getCurrentState();
  }
}
