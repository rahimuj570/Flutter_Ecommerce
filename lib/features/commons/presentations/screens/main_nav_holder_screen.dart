import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/state_management/theme_provider.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signin_screen.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';
import 'package:flutter_ecommerce/features/cart/presentations/screens/cart_screen.dart';
import 'package:flutter_ecommerce/features/categories/presentations/screens/categories_screen.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:flutter_ecommerce/features/home/presentations/screens/home_screen.dart';
import 'package:flutter_ecommerce/features/wish_list/presentations/screens/product_list_by_wish.dart';
import 'package:provider/provider.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});
  static final String name = '/main_nav_holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    ProductListByWish(),
  ];

  @override
  Widget build(BuildContext context) {
    final MainNavBarProvider mainNavBarProvider = context.watch();
    return SafeArea(
      child: Scaffold(
        body: _screens[mainNavBarProvider.getSelectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: context.read<ThemeProvider>().isDark! == false
                    ? const Color(0xFFE0E0E0)
                    : const Color.fromARGB(
                        255,
                        104,
                        102,
                        102,
                      ), // light grey top border
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            onTap: (value) => _onTapNavButton(value, mainNavBarProvider),
            type: BottomNavigationBarType.fixed,
            backgroundColor: context.read<ThemeProvider>().isDark! == false
                ? Colors.white
                : null,
            elevation: 0,
            currentIndex: mainNavBarProvider.getSelectedIndex,
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

  void _onTapNavButton(int value, MainNavBarProvider mainNavBarProvider) async {
    // print('ssssssssssssssssss $value');
    if ([2, 3].contains(value)) {
      if (await AuthManagement.isLoggedIn() == false) {
        if (mounted) {
          Navigator.pushNamed(context, SigninScreen.name);
        }
      } else {
        mainNavBarProvider.changeIndex(value);
      }
    } else {
      mainNavBarProvider.changeIndex(value);
    }
  }
}
