import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});
  static final String name = '/main_nav_holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actionsPadding: EdgeInsets.all(5),
          toolbarHeight: 60,
          title: SvgPicture.asset(AppAssetsPath.appbarLogo, width: 130),
          actions: [
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.grey,
              ),
              onPressed: () {},
              icon: Icon(Icons.person_2_outlined),
            ),

            IconButton(
              style: IconButton.styleFrom(
                foregroundColor: Colors.grey,
                backgroundColor: Colors.grey.shade200,
              ),
              onPressed: () {},
              icon: Icon(Icons.call_outlined),
            ),
            IconButton(
              style: IconButton.styleFrom(
                foregroundColor: Colors.grey,
                backgroundColor: Colors.grey.shade200,
              ),
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
