import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_routes.dart';
import 'package:flutter_ecommerce/app/app_themes.dart';
import 'package:flutter_ecommerce/app/state_management/language_provider.dart';
import 'package:flutter_ecommerce/app/state_management/theme_provider.dart';
import 'package:flutter_ecommerce/features/categories/state_management/category_provider.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:flutter_ecommerce/features/home/state_management/slider_provider.dart';
import 'package:flutter_ecommerce/features/cart/state_management/cart_provider.dart';
import 'package:flutter_ecommerce/features/products/state_management/product_provider.dart';
import 'package:flutter_ecommerce/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class FlutterEcommerce extends StatefulWidget {
  const FlutterEcommerce({super.key});
  static GlobalKey<NavigatorState> globalRoute = GlobalKey<NavigatorState>();
  @override
  State<FlutterEcommerce> createState() => _FlutterEcommerceState();
}

class _FlutterEcommerceState extends State<FlutterEcommerce> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => MainNavBarProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => SliderProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: Consumer3<LanguageProvider, ThemeProvider, MainNavBarProvider>(
        builder:
            (context, langProvider, themeProvider, mainNavBarProvider, child) =>
                MaterialApp(
                  navigatorKey: FlutterEcommerce.globalRoute,
                  initialRoute: '/',
                  onGenerateRoute: AppRoutes.appRoutes,
                  theme: AppThemes.light,
                  darkTheme: AppThemes.dark,
                  themeMode: themeProvider.getThemeMode,
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
                  locale: langProvider.getLocal,
                ),
      ),
    );
  }
}
