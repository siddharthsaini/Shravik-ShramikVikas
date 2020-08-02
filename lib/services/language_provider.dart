import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Shravik/localizations.dart';
import 'package:Shravik/store/store.dart';

class LanguageProvider extends ChangeNotifier {
  SharedPreferenceHelper _sharedPrefsHelper;

  String _currentLanguage = '';

  LanguageProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  setInitialLocalLanguage() async {
    _sharedPrefsHelper.appCurrentLanguage.then((currentLanguageCode) async {
      if ((currentLanguageCode == '') || (currentLanguageCode == null)) {
        const MethodChannel _channel =
            const MethodChannel('uk.spiralarm.flutter/devicelocale');
        final List deviceLanguages =
            await _channel.invokeMethod('preferredLanguages');
        String deviceLanguage = deviceLanguages.first;
        deviceLanguage = deviceLanguage.substring(0, 2);
        print('deviceLanguage: ' + deviceLanguage);
        updateLanguage(deviceLanguage);
      }
    });
  }

  String get currentLanguage {
    _sharedPrefsHelper.appCurrentLanguage.then((value) {
      _currentLanguage = value;
    });

    return _currentLanguage;
  }

  Locale get getLocale {
    Locale _updatedLocal = AppLocalizations.languages.keys.first;
    AppLocalizations.languages.keys.forEach((locale) {
      if (locale.languageCode == currentLanguage) {
        _updatedLocal = locale;
      }
    });
    return _updatedLocal;
  }

  void updateLanguage(String selectedLanguage) {
    _sharedPrefsHelper.changeLanguage(selectedLanguage);
    _sharedPrefsHelper.appCurrentLanguage.then((languageSelected) {
      _currentLanguage = languageSelected;
    });

    notifyListeners();
  }
}
