import 'package:gugu/core/presentation/state-machine.dart';

class AudioCallStateMachine
    extends StateMachine<AudioCallState, AudioCallEvent> {
  AudioCallStateMachine() : super(AudioCallCallingState());

  @override
  AudioCallState getStateOnEvent(AudioCallEvent event) {
    final eventType = event.runtimeType;
    AudioCallState newState = getCurrentState();
    switch (eventType) {
      case AudioCallJoinedEvent:
        newState = new AudioCallJoinedState();
        break;
      case AudioCallEndEvent:
        newState = new AudioCallEndState();
        break;
    }
    return newState;
  }
}

class AudioCallState {}

class AudioCallCallingState extends AudioCallState {}

class AudioCallJoinedState extends AudioCallState {}

class AudioCallEndState extends AudioCallState {}

class AudioCallEvent {}

class AudioCallJoinedEvent extends AudioCallEvent {}

class AudioCallEndEvent extends AudioCallEvent {}
