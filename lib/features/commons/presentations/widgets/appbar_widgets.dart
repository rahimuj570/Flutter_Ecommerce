import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/state_management/language_provider.dart';
import 'package:flutter_ecommerce/app/state_management/theme_provider.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';
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
  int selectLang = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) => AppBar(
        backgroundColor: value.isDark == false ? Colors.white : null,
        actionsPadding: EdgeInsets.all(5),
        toolbarHeight: 60,
        title: SvgPicture.asset(AppAssetsPath.appbarLogo, width: 130),
        actions: [
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  icon: Icon(Icons.language, size: 18),
                  borderRadius: BorderRadius.circular(20),
                  value: languageProvider.getLocal,
                  items: [
                    DropdownMenuItem(
                      value: Locale('bn'),
                      child: Text('বাংলা', style: TextStyle(fontSize: 14)),
                    ),
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Text('English', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                  onChanged: (value) {
                    languageProvider.changeLocale(value!);
                  },
                ),
              ),
            ),
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

          PopupMenuButton(
            icon: Card(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(Icons.person_outline, color: Colors.grey),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'profile', child: Text('Profile')),
              PopupMenuItem(
                value: 'logout',
                onTap: () {
                  AuthManagement.cleatUser();
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
