import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';

class AppThemes {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.themeColor,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.themeColor,
    );
  }
}
