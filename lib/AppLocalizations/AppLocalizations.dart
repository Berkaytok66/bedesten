import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, dynamic> _localizedStrings; // Map'in tipini güncelledik

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)
        ?? (throw Exception('Unable to locate AppLocalizations object.'));
  }

  // Load the language JSON file from the "lang" folder.
  Future<void> load() async {
    String jsonString = await rootBundle.loadString('images/langue/${locale.languageCode}.json'); // 'images/langue' yerine 'lang' kullanıldı
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap; // İç içe yapıyı doğrudan atıyoruz
  }

  // This method will be called from every widget that needs a localized text.
  // İç içe yapıyı destekleyecek şekilde translate metodunu güncelliyoruz.
  String translate(String key) {
    final keys = key.split('.'); // 'login.email' gibi bir giriş için nokta ile ayırıyoruz
    dynamic value = _localizedStrings;

    for (String k in keys) {
      value = value[k] ?? '[$k]';
      if (value is! Map) break;
    }

    return value.toString(); // Son değeri string'e çeviriyoruz
  }

  // LocalizationsDelegate is a factory for a set of localized resources.
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all supported language codes here.
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}