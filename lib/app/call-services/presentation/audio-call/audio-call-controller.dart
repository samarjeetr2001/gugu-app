import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/core/presentation/observer.dart';

import '../../../../injection-container.dart';
import '../../../navigation-service.dart';
import 'audio-call-presenter.dart';
import 'audio-call-state-machine.dart';

class AudioCallController extends Controller {
  final AudioCallPresenter _presenter;
  final AudioCallStateMachine _stateMachine;
  final NavigationService _navigationService;
  AudioCallController()
      : _presenter = serviceLocator<AudioCallPresenter>(),
        _stateMachine = new AudioCallStateMachine(),
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

  AudioCallState getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  void connectCall() {
    _stateMachine.onEvent(new AudioCallJoinedEvent());
    refreshUI();
  }

  void endCall({required String userID}) {
    _presenter.endCall(
      observer: new UseCaseObserver(
        () {
          _navigationService.navigateBack();
        },
        (error) {},
      ),
      userID: userID,
    );
  }
}
