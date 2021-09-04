import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../phone-auth-state-machine.dart';
import '../../../../../core/presentation/states/error-state.dart';
import '../../../../../core/presentation/states/loading-state.dart';
import '../phone-auth-controller.dart';

class PhoneAuthView extends View {
  @override
  State<StatefulWidget> createState() => PhoneAuthViewState();
}

class PhoneAuthViewState
    extends ResponsiveViewState<PhoneAuthView, PhoneAuthController> {
  final TextEditingController _phoneNumberTextEditingController =
      new TextEditingController();
  final TextEditingController _codeTextEditingController =
      new TextEditingController();
  PhoneAuthViewState() : super(new PhoneAuthController());

  @override
  Widget get desktopView => throw UnimplementedError();

  @override
  Widget get mobileView {
    return ControlledWidgetBuilder<PhoneAuthController>(
        builder: (context, controller) {
      final currentStateType = controller.getCurrentState().runtimeType;
      print("DesktopView called with state $currentStateType");

      switch (currentStateType) {
        case PhoneAuthInitState:
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _phoneNumberTextEditingController,
                ),
                TextButton(
                  onPressed: () {
                    controller.verifyPhoneNumber(
                        phoneNumber: _phoneNumberTextEditingController.text);
                  },
                  child: Text("Send OTP"),
                ),
              ],
            ),
          );
        case PhoneAuthVerifyCodeState:
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _codeTextEditingController,
                ),
                TextButton(
                  onPressed: () {
                    controller.verifyCode(
                        code: _codeTextEditingController.text);
                  },
                  child: Text("check OTP"),
                ),
              ],
            ),
          );
        case PhoneAuthErrorState:
          return Scaffold(
            body: Center(
              child: ErrorState(),
            ),
          );
        case PhoneAuthLoadingState:
          return Scaffold(
            body: Center(
              child: LoadingState(),
            ),
          );
      }
      throw Exception("Unrecognized state $currentStateType encountered");
    });
  }

  @override
  Widget get tabletView => throw UnimplementedError();

  @override
  Widget get watchView => throw UnimplementedError();
}
