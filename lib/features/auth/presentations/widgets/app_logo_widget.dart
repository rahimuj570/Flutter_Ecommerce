import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_svg/svg.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key, this.width, this.height});

  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppAssetsPath.logo, width: width, height: height);
  }
}
