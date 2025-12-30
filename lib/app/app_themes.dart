import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';

class AppThemes {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorSchemeSeed: AppColors.themeColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.themeColor,
      ),
      inputDecorationTheme: _inputDecorationThemeData(isDark: false),
      filledButtonTheme: _filledButtonThemeData(),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: AppColors.themeColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.themeColor,
      ),
      inputDecorationTheme: _inputDecorationThemeData(isDark: true),
      filledButtonTheme: _filledButtonThemeData(),
    );
  }

  static InputDecorationTheme _inputDecorationThemeData({
    required bool isDark,
  }) {
    return InputDecorationTheme(
      hintStyle: TextStyle(
        color: isDark ? Colors.white : Colors.grey,
        fontSize: 16,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor, width: 20),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor, width: 2),
      ),
    );
  }

  static FilledButtonThemeData _filledButtonThemeData() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        fixedSize: Size.fromWidth(double.maxFinite),
        padding: EdgeInsets.all(12),
        textStyle: TextStyle(fontSize: 16),
        backgroundColor: AppColors.themeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
      ),
    );
  }
}
