import 'package:flutter/material.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  static final CustomRouteObserver _instance = CustomRouteObserver._internal();

  final List<String> _navStack = [];

  factory CustomRouteObserver() {
    return _instance;
  }

  CustomRouteObserver._internal();

  List<String> get pages => List.unmodifiable(_navStack);

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    final screenName = route.settings.name;

    if (screenName != null) {
      _navStack.add(screenName);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    _navStack.remove(route.settings.name);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);

    _navStack.remove(route.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      _navStack.remove(oldRoute.settings.name);
    }
    if (newRoute != null && newRoute.settings.name != null) {
      _navStack.add(newRoute.settings.name!);
    }
  }
}