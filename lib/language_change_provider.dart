import 'package:flutter/cupertino.dart';

class LanguageChangeProvider with ChangeNotifier{
  Locale _currentLocale=Locale("en");

Locale get currentLocale=>_currentLocale;
  void changLocale(String _locale){
    this._currentLocale=Locale(_locale);
    notifyListeners();
  }
}