import 'package:gugu/core/presentation/state-machine.dart';

class PhoneAuthStateMachine
    extends StateMachine<PhoneAuthState, PhoneAuthEvent> {
  PhoneAuthStateMachine() : super(PhoneAuthInitState());

  @override
  PhoneAuthState getStateOnEvent(PhoneAuthEvent event) {
    final eventType = event.runtimeType;
    PhoneAuthState newState = getCurrentState();
    switch (eventType) {
      case PhoneAuthLoadingEvent:
        newState = new PhoneAuthLoadingState();
        break;
      case PhoneAuthVerifyCodeEvent:
        newState = new PhoneAuthVerifyCodeState();
        break;
      case PhoneAuthErrorEvent:
        newState = new PhoneAuthErrorState();
        break;
      case PhoneAuthChangePhoneNumberEvent:
        newState = new PhoneAuthInitState();
        break;
      default:
        throw Exception("Invalid event $eventType : PhoneAuthStateMachine");
    }
    return newState;
  }
}

class PhoneAuthState {}

class PhoneAuthInitState extends PhoneAuthState {}

class PhoneAuthLoadingState extends PhoneAuthState {}

class PhoneAuthVerifyCodeState extends PhoneAuthState {}

class PhoneAuthErrorState extends PhoneAuthState {}

class PhoneAuthEvent {}

class PhoneAuthLoadingEvent extends PhoneAuthEvent {}

class PhoneAuthVerifyCodeEvent extends PhoneAuthEvent {}

class PhoneAuthErrorEvent extends PhoneAuthEvent {}

class PhoneAuthChangePhoneNumberEvent extends PhoneAuthEvent {}
