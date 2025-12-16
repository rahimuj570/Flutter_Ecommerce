import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/forgot_password_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signin_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/splash_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/verify_otp_screen.dart';
import 'package:flutter_ecommerce/features/commons/main_nav_holder_screen.dart';

class AppRoutes {
  static Route<dynamic> appRoutes(RouteSettings settings) {
    Widget widget = SizedBox();

    if (settings.name == SplashScreen.name) {
      widget = SplashScreen();
    } else if (settings.name == SignupScreen.name) {
      widget = SignupScreen();
    } else if (settings.name == SigninScreen.name) {
      widget = SigninScreen();
    } else if (settings.name == ForgotPasswordScreen.name) {
      widget = ForgotPasswordScreen();
    } else if (settings.name == VerifyOtpScreen.name) {
      widget = VerifyOtpScreen();
    } else if (settings.name == MainNavHolderScreen.name) {
      widget = MainNavHolderScreen();
    }

    return MaterialPageRoute(builder: (context) => widget);
  }
}
