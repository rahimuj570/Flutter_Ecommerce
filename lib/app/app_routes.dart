import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/forgot_password_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signin_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/splash_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/verify_otp_screen.dart';
import 'package:flutter_ecommerce/features/categories/presentations/screens/categories_screen.dart';
import 'package:flutter_ecommerce/features/commons/presentations/screens/main_nav_holder_screen.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_list_by_category.dart';
import 'package:flutter_ecommerce/features/wish_list/presentations/screens/product_list_by_wish.dart';

class AppRoutes {
  static Route<dynamic> appRoutes(RouteSettings settings) {
    Widget widget = SizedBox();

    if (settings.name == SplashScreen.name) {
      widget = SplashScreen();
    } else if (settings.name == SignupScreen.name) {
      widget = SignupScreen();
    } else if (settings.name == SigninScreen.name) {
      String? tmp = settings.arguments as String?;
      widget = SigninScreen(isComesFromRunningProcess: tmp);
    } else if (settings.name == ForgotPasswordScreen.name) {
      widget = ForgotPasswordScreen();
    } else if (settings.name == VerifyOtpScreen.name) {
      String email = settings.arguments as String;
      widget = VerifyOtpScreen(email: email);
    } else if (settings.name == MainNavHolderScreen.name) {
      widget = MainNavHolderScreen();
    } else if (settings.name == CategoriesScreen.name) {
      widget = CategoriesScreen();
    } else if (settings.name == ProductListByCategory.name) {
      widget = ProductListByCategory(
        arguments: settings.arguments as Map<String, dynamic>,
      );
    } else if (settings.name == ProductListByWish.name) {
      widget = ProductListByWish();
    } else if (settings.name == ProductDetailsScreen.name) {
      String _productId = settings.arguments as String;
      widget = ProductDetailsScreen(productId: _productId);
    }

    return MaterialPageRoute(builder: (context) => widget);
  }
}
