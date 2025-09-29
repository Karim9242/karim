import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_shopping_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'utils/locale_helper.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  final LocaleHelper _localeHelper = LocaleHelper();

  @override
  void initState() {
    super.initState();
    _localeHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleHelper>.value(
      value: _localeHelper,
      child: Consumer<LocaleHelper>(
        builder: (context, localeHelper, child) {
          return MaterialApp(
            title: 'Flutter Shopping App',
            debugShowCheckedModeBanner: false,
            locale: localeHelper.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Suwannaphum',
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const WelcomeScreen(),
            builder: (context, child) {
              return Directionality(
                textDirection: localeHelper.currentLocale.languageCode == 'ar' 
                    ? TextDirection.rtl 
                    : TextDirection.ltr,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}