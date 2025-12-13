import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_ecommerce/app/extensions/localization_extension.dart';
import 'package:flutter_ecommerce/app/state_management/language_provider.dart';
import 'package:flutter_ecommerce/app/state_management/theme_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    bool isDark = themeProvider.getThemeMode.name == 'dark';
    return Scaffold(
      body: Stack(
        children: [
          Center(child: SvgPicture.asset(AppAssetsPath.logo)),
          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 30),
                Text("Version 1.0"),
              ],
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       SvgPicture.asset(AppAssetsPath.logo),
      //       CircularProgressIndicator(),
      //     ],
      //   ),
      // ),
    );
  }
}
