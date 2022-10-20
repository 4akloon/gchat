import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../views/login/login.view.dart';
import '../views/main/main.view.dart';
import '../views/passcode/passcode.view.dart';

class AppRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case LoginView.name:
        return GetPageRoute(
          routeName: LoginView.name,
          page: () => LoginView(),
        );
      case PasscodeView.name:
        if (args is PasscodeArgs) {
          return GetPageRoute(
            routeName: PasscodeView.name,
            page: () => PasscodeView(args: args),
          );
        }
        break;
      case MainView.name:
        return GetPageRoute(
          routeName: MainView.name,
          page: () => const MainView(),
        );
      default:
        break;
    }
    return GetPageRoute(
      page: () => const Scaffold(body: Center(child: Text('error'))),
    );
  }
}
