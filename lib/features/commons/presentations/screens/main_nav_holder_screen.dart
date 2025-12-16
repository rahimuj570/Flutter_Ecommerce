import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});
  static final String name = '/main_nav_holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  @override
  Widget build(BuildContext context) {
    final MainNavBarProvider _mainNavBarProvider = context.watch();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xFFE0E0E0), // light grey top border
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            onTap: (value) {
              _mainNavBarProvider.changeIndex(value);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            currentIndex: _mainNavBarProvider.getSelectedIndex,
            selectedItemColor: AppColors.themeColor,
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 11,
            showUnselectedLabels: true,
            iconSize: 28,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard_outlined),
                label: 'Wish',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
