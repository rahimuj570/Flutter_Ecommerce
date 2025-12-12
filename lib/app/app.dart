import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_routes.dart';
import 'package:flutter_ecommerce/app/app_themes.dart';
import 'package:flutter_ecommerce/app/state_management/language_provider.dart';
import 'package:flutter_ecommerce/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class FlutterEcommerce extends StatefulWidget {
  const FlutterEcommerce({super.key});

  @override
  State<FlutterEcommerce> createState() => _FlutterEcommerceState();
}

class _FlutterEcommerceState extends State<FlutterEcommerce> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, value, child) => MaterialApp(
          initialRoute: '/',
          onGenerateRoute: AppRoutes.appRoutes,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: ThemeMode.light,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('bn'), // Bangla
          ],
          locale: value.getLocal,
        ),
      ),
    );
  }
}
