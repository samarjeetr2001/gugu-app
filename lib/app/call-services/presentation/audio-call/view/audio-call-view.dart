import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/call-services/domain/entity/call-entity.dart';
import 'package:gugu/app/call-services/presentation/audio-call/audio-call-state-machine.dart';
import 'package:gugu/core/presentation/widgets/in-coming-call-page.dart';
import 'package:gugu/core/presentation/widgets/out-going-call-page.dart';

import '../audio-call-controller.dart';

class AudioCallView extends View {
  final AudioCallViewParams params;

  AudioCallView(this.params);

  @override
  State<StatefulWidget> createState() => AudioCallViewState();
}

class AudioCallViewState
    extends ResponsiveViewState<AudioCallView, AudioCallController> {
  AudioCallViewState() : super(new AudioCallController());

  @override
  Widget get desktopView => throw UnimplementedError();

  @override
  Widget get mobileView {
    return ControlledWidgetBuilder<AudioCallController>(
      builder: (context, controller) {
        final currentStateType = controller.getCurrentState().runtimeType;
        // final currentState = controller.getCurrentState();

        print("Mobile View Called With State $currentStateType");
        switch (currentStateType) {
          case AudioCallCallingState:
            return widget.params.callData.isReceiver!
                ? InComingCallPage(
                    acceptCallFunction: () {
                      controller.connectCall();
                    },
                    declineCallFunction: () {
                      controller.endCall(
                          userID: widget.params.callData.receiver.id);
                    },
                  )
                : OutGoingCallPage(
                    endCallFunction: () {
                      controller.endCall(
                          userID: widget.params.callData.dialer.id);
                    },
                  );

          case AudioCallJoinedState:
            return Scaffold(
              body: Center(
                child: Text("Connected....."),
              ),
            );

          case AudioCallEndState:
            return Scaffold(
              body: Center(
                child: Text("Ended........"),
              ),
            );

          default:
            throw Exception(
                "Unknown State: $currentStateType: ProductDetailDesktopView");
        }
      },
    );
  }

  @override
  Widget get tabletView => throw UnimplementedError();

  @override
  Widget get watchView => throw UnimplementedError();
}

class AudioCallViewParams {
  final CallEntity callData;

  AudioCallViewParams({required this.callData});
}
