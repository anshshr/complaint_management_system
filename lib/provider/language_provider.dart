import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale;

  LanguageProvider(this._locale);

  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
  }
}
