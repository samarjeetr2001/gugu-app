import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String signInRoute = "/sign-in";
  static const String registrationRoute = "/registration";
  static const String homeRoute = "/home";
  static const String productCardsRoute = "/product-cards";
  static const String productDetailRoute = "/product-detail";
  static const String wishlistRoute = "/wishlist";
  static const String cartRoute = "/cart";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
