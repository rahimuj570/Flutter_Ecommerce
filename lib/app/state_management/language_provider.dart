import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _locale = Locale('en');

  LanguageProvider() {
    _savedLocale();
  }

  Locale get getLocal => _locale;

  void changeLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      _saveLocale(newLocale.languageCode);
      notifyListeners();
    }
  }

  Future<void> _saveLocale(String lang) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('locale', lang);
  }

  Future<void> _savedLocale() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String savedLang = preferences.getString('locale') ?? 'en';
    _locale = Locale(savedLang);
    notifyListeners();
  }
}
