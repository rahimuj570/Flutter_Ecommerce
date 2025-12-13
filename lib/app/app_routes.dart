import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/splash_screen.dart';

class AppRoutes {
  static Route<dynamic> appRoutes(RouteSettings settings) {
    Widget widget = SizedBox();

    if (settings.name == SplashScreen.name) {
      widget = SplashScreen();
    } else if (settings.name == SignupScreen.name) {
      widget = SignupScreen();
    }

    return MaterialPageRoute(builder: (context) => widget);
  }
}
