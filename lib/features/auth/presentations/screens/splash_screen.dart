import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/state_management/language_provider.dart';
import 'package:flutter_ecommerce/l10n/app_localizations.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.hello),
            Text(AppLocalizations.of(context)!.changeLaguage),

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
          ],
        ),
      ),
    );
  }
}
