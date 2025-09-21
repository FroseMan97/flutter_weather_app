class ServerException implements Exception {
  final String message;
  
  const ServerException(this.message);
  
  @override
  String toString() => 'Server error: $message';
}

class NetworkException implements Exception {
  final String message;
  
  const NetworkException(this.message);
  
  @override
  String toString() => 'Network error: $message';
}

class CacheException implements Exception {
  final String message;
  
  const CacheException(this.message);
  
  @override
  String toString() => 'Cache error: $message';
}

class AuthException implements Exception {
  final String message;
  
  const AuthException(this.message);
  
  @override
  String toString() => 'Authorization error: $message';
}


