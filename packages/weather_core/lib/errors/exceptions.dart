import 'package:weather_localization/weather_localization.dart';

class ServerException implements Exception {
  final String message;
  
  const ServerException(this.message);
  
  @override
  String toString() => '${AppLocalization.serverError}: $message';
}

class NetworkException implements Exception {
  final String message;
  
  const NetworkException(this.message);
  
  @override
  String toString() => '${AppLocalization.networkError}: $message';
}

class CacheException implements Exception {
  final String message;
  
  const CacheException(this.message);
  
  @override
  String toString() => '${AppLocalization.cacheError}: $message';
}

class AuthException implements Exception {
  final String message;
  
  const AuthException(this.message);
  
  @override
  String toString() => '${AppLocalization.authError}: $message';
}


