import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';
import 'package:flutter_ecommerce/features/commons/presentations/screens/main_nav_holder_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIsUserLoggedIn();
  }

  Future<void> _gotoNext({required bool inHomePage}) async {
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      inHomePage
          ? Navigator.pushReplacementNamed(context, MainNavHolderScreen.name)
          : Navigator.pushReplacementNamed(context, SignupScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: AppLogoWidget()),
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

  Future<void> _checkIsUserLoggedIn() async {
    if (await AuthManagement.isLoggedIn()) {
      await AuthManagement.loadUser();
      _gotoNext(inHomePage: true);
    } else {
      _gotoNext(inHomePage: false);
    }
  }
}
