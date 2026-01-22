import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/state_management/theme_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AppbarWidgets extends StatefulWidget implements PreferredSizeWidget {
  const AppbarWidgets({super.key});

  @override
  State<AppbarWidgets> createState() => _AppbarWidgetsState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}

class _AppbarWidgetsState extends State<AppbarWidgets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) => AppBar(
        backgroundColor: value.isDark == false ? Colors.white : null,
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

          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) => Switch(
              value: themeProvider.isDark!,
              onChanged: (value) {
                if (value) {
                  themeProvider.changeThemeMode(ThemeMode.dark);
                } else {
                  themeProvider.changeThemeMode(ThemeMode.light);
                }
              },
              thumbIcon: WidgetStateProperty.all(
                themeProvider.isDark == false
                    ? Icon(Icons.sunny, color: Colors.black)
                    : Icon(Icons.nightlight_round),
              ),
              thumbColor: WidgetStatePropertyAll(
                themeProvider.isDark! == false ? Colors.orangeAccent : null,
              ),

              trackColor: WidgetStatePropertyAll(AppColors.themeColor),
            ),
          ),
        ],
      ),
    );
  }
}
