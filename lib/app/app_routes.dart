import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/auth/presentations/screens/splash_screen.dart';

class AppRoutes {
  static Route<dynamic> appRoutes(RouteSettings settings) {
    Widget widget = SizedBox();

    if (settings.name == SplashScreen.name) {
      widget = SplashScreen();
    }

    return MaterialPageRoute(builder: (context) => widget);
  }
}
