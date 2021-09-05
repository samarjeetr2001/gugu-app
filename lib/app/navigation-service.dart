import 'package:flutter/material.dart';
import 'package:gugu/app/authentication/presentation/phone-auth/view/phone-auth-view.dart';

import 'home-page.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String homeRoute = "/home";
  static const String loginRoute = "/login";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: NavigationService.loginRoute),
            builder: (_) => PhoneAuthView());
      case homeRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: NavigationService.homeRoute),
            builder: (_) => MyHomePage());
      default:
        throw Exception("NavigationService: Invalid Navigation ");
    }
  }

  Future<void> navigateTo(String routeName,
      {bool shouldReplace = false, Object? arguments}) {
    if (shouldReplace) {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    }
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void navigateBack() {
    return navigatorKey.currentState!.pop();
  }

  void navigatePopUntil(String untilRoute) {
    return navigatorKey.currentState!
        .popUntil(ModalRoute.withName('$untilRoute'));
  }
}
