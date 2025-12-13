import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/extensions/localization_extension.dart';
import 'package:flutter_ecommerce/app/state_management/language_provider.dart';
import 'package:flutter_ecommerce/app/state_management/theme_provider.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.localization.hello),
            Text(context.localization.changeLaguage),

            DropdownMenu(
              onSelected: (value) => context
                  .read<LanguageProvider>()
                  .changeLocale(Locale(value.toString())),
              initialSelection: context
                  .read<LanguageProvider>()
                  .getLocal
                  .languageCode,
              dropdownMenuEntries: [
                DropdownMenuEntry(enabled: true, value: 'en', label: 'English'),
                DropdownMenuEntry(value: 'bn', label: 'Bengali'),
              ],
            ),
            Switch(
              value: isDark,
              onChanged: (value) {
                if (value) {
                  themeProvider.changeThemeMode(ThemeMode.dark);
                } else {
                  themeProvider.changeThemeMode(ThemeMode.light);
                }
                isDark = value;
                print(value);
                // setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
