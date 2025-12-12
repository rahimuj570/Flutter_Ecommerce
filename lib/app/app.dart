import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_routes.dart';
import 'package:flutter_ecommerce/app/app_themes.dart';

class FlutterEcommerce extends StatefulWidget {
  const FlutterEcommerce({super.key});

  @override
  State<FlutterEcommerce> createState() => _FlutterEcommerceState();
}

class _FlutterEcommerceState extends State<FlutterEcommerce> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.appRoutes,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.light,
    );
  }
}
