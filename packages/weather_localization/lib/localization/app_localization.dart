import 'package:easy_localization/easy_localization.dart';

class AppLocalization {
  // UI Texts
  static String get appTitle => 'appTitle'.tr();
  static String get searchCity => 'searchCity'.tr();
  static String get enterCityName => 'enterCityName'.tr();
  static String get selectCityForWeather => 'selectCityForWeather'.tr();
  static String get loadingWeather => 'loadingWeather'.tr();
  static String get tryAgain => 'tryAgain'.tr();
  static String get error => 'error'.tr();
  static String get citiesNotFound => 'citiesNotFound'.tr();
  static String get pleaseEnterCityName => 'pleaseEnterCityName'.tr();
  static String get cityNameOnlyLetters => 'cityNameOnlyLetters'.tr();
  static String get feelsLike => 'feelsLike'.tr();
  static String get humidity => 'humidity'.tr();
  static String get wind => 'wind'.tr();
  static String get updated => 'updated'.tr();
  static String get mps => 'mps'.tr();
  
  // Error Messages
  static String get serverError => 'serverError'.tr();
  static String get networkError => 'networkError'.tr();
  static String get cacheError => 'cacheError'.tr();
  static String get authError => 'authError'.tr();
  static String get unexpectedError => 'unexpectedError'.tr();
  static String get failedToGetAccessToken => 'failedToGetAccessToken'.tr();
  static String get networkTimeout => 'networkTimeout'.tr();
  static String get noInternetConnection => 'noInternetConnection'.tr();
  static String get tokenExpired => 'tokenExpired'.tr();
  static String get failedToFindCities => 'failedToFindCities'.tr();
  static String get failedToGetWeatherData => 'failedToGetWeatherData'.tr();
}


