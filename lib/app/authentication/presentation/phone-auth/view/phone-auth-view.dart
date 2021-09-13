import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:image_picker/image_picker.dart';

import '../phone-auth-state-machine.dart';
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
  final TextEditingController _nameTextEditingController =
      new TextEditingController();
  final TextEditingController _bioTextEditingController =
      new TextEditingController(text: "HelloWorld!");
  Uint8List? userImageData;
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
        case PhoneAuthRegistrationState:
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _nameTextEditingController,
                  validator: (value) {
                    if (value != null) if (value.length < 2)
                      return "name is in-valid";
                  },
                  decoration: InputDecoration(labelText: "name"),
                ),
                TextFormField(
                  controller: _bioTextEditingController,
                  decoration: InputDecoration(labelText: "Bio Message"),
                ),
                if (userImageData != null)
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(
                          userImageData!,
                        ),
                      ),
                    ),
                  ),
                if (userImageData == null)
                  TextButton(
                    onPressed: () {
                      getImage(controller);
                    },
                    child: Text("Add Image"),
                  ),
                TextButton(
                  onPressed: () {
                    if (_nameTextEditingController.text.length >= 2 ||
                        userImageData != null)
                      controller.registerUser(
                          phoneNumber: _phoneNumberTextEditingController.text,
                          name: _nameTextEditingController.text,
                          bioMessage: _bioTextEditingController.text,
                          profilePhoto: userImageData!);
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
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

  Future getImage(PhoneAuthController controller) async {
    Uint8List temp;
    // ignore: invalid_use_of_visible_for_testing_member
    PickedFile? _image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (_image != null) {
      temp = await _image.readAsBytes();
      userImageData = temp;
    }
    controller.refresh();
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
