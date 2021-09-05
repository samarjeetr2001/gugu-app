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
            body: phoneVerificationContentBody(controller),
          );
        case PhoneAuthVerifyCodeState:
          return Scaffold(
            body: verificationCodeContentBody(controller),
          );
        case PhoneAuthErrorState:
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                currentStateType == PhoneAuthInitState
                    ? phoneVerificationContentBody(controller)
                    : verificationCodeContentBody(controller),
                SizedBox(
                  height: 50,
                  child: Text("**ERROR**"),
                )
              ],
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

  Column phoneVerificationContentBody(PhoneAuthController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          controller: _phoneNumberTextEditingController,
          validator: (value) {
            if (value != null) if (value.length != 10)
              return "number is in-valid";
          },
          decoration: InputDecoration(labelText: ""),
        ),
        TextButton(
          onPressed: () {
            if (_phoneNumberTextEditingController.text.length == 10)
              controller.verifyPhoneNumber(
                  phoneNumber: _phoneNumberTextEditingController.text);
          },
          child: Text("Send "),
        ),
      ],
    );
  }

  Column verificationCodeContentBody(PhoneAuthController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          controller: _codeTextEditingController,
          validator: (value) {
            if (value != null) if (value.length != 6) return "code is in-valid";
          },
          decoration: InputDecoration(labelText: ""),
        ),
        TextButton(
          onPressed: () {
            if (_codeTextEditingController.text.length == 6)
              controller.verifyCode(code: _codeTextEditingController.text);
          },
          child: Text("Check "),
        ),
        TextButton(
          onPressed: () {
            controller.changePhoneNumber();
          },
          child: Text("Change mobile number "),
        ),
        TextButton(
          onPressed: () {
            controller.verifyPhoneNumber(
                phoneNumber: _phoneNumberTextEditingController.text);
          },
          child: Text("Resend OTP"),
        ),
      ],
    );
  }

  @override
  Widget get tabletView => throw UnimplementedError();

  @override
  Widget get watchView => throw UnimplementedError();
}
