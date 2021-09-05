import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'splash-screen-controller.dart';

class SplashScreenView extends View {
  @override
  State<StatefulWidget> createState() => SplashScreenViewState();
}

class SplashScreenViewState
    extends ResponsiveViewState<SplashScreenView, SplashScreenController> {
  SplashScreenViewState() : super(new SplashScreenController());

  @override
  Widget get desktopView => throw UnimplementedError();

  @override
  Widget get mobileView {
    return ControlledWidgetBuilder<SplashScreenController>(
        builder: (context, controller) {
      controller.checkLoginStatus();
      return Scaffold(
        body: Center(
          child: Icon(Icons.ac_unit_sharp),
        ),
      );
    });
  }

  @override
  Widget get tabletView => throw UnimplementedError();

  @override
  Widget get watchView => throw UnimplementedError();
}
