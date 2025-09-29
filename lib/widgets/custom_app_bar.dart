import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../utils/locale_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  
  const CustomAppBar({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    final localeHelper = Provider.of<LocaleHelper>(context);
    // ignore: unused_local_variable
    final localizations = AppLocalizations.of(context)!;
    
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Suwannaphum',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.deepPurple,
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.language),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'en',
              child: Text(
                'English',
                style: TextStyle(
                  fontFamily: 'Suwannaphum',
                  fontWeight: localeHelper.currentLocale.languageCode == 'en' 
                      ? FontWeight.bold 
                      : FontWeight.normal
                ),
              ),
            ),
            PopupMenuItem(
              value: 'ar',
              child: Text(
                'العربية',
                style: TextStyle(
                  fontFamily: 'Suwannaphum',
                  fontWeight: localeHelper.currentLocale.languageCode == 'ar' 
                      ? FontWeight.bold 
                      : FontWeight.normal
                ),
              ),
            ),
          ],
          onSelected: (value) {
            localeHelper.changeLocale(value);
          },
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}