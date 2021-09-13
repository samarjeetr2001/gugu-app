import '../../../core/presentation/state-machine.dart';

class HomeStateMachine extends StateMachine<HomeState, HomeEvent> {
  HomeStateMachine() : super(HomeInitializationState());

  @override
  HomeState getStateOnEvent(HomeEvent event) {
    final eventType = event.runtimeType;
    HomeState newState = getCurrentState();
    switch (eventType) {
    }
    return newState;
  }
}

class HomeState {}

class HomeInitializationState extends HomeState {}

class HomeEvent {}
