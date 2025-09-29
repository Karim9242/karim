import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleHelper with ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  
  Locale get currentLocale => _currentLocale;
  
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString('app_locale') ?? 'en';
    _currentLocale = Locale(localeCode);
    notifyListeners();
  }
  
  Future<void> changeLocale(String localeCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_locale', localeCode);
    _currentLocale = Locale(localeCode);
    notifyListeners();
  }
}