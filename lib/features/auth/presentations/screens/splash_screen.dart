import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_svg/svg.dart';

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
    _gotoNext();
  }

  Future<void> _gotoNext() async {
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, SignupScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
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
