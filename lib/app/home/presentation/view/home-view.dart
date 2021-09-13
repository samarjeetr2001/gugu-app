import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../home-controller.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends ResponsiveViewState<HomeView, HomeController> {
  HomeViewState() : super(new HomeController());

  @override
  Widget get desktopView => throw UnimplementedError();

  @override
  Widget get mobileView => throw UnimplementedError();

  @override
  Widget get tabletView => throw UnimplementedError();

  @override
  Widget get watchView => throw UnimplementedError();
}
