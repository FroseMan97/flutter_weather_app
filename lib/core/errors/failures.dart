abstract class Failure {
  const Failure();
  
  @override
  String toString() => 'Error';
}

// General failures
class ServerFailure extends Failure {
  final String message;
  
  const ServerFailure(this.message);
  
  @override
  String toString() => 'Server error: $message';
}

class NetworkFailure extends Failure {
  final String message;
  
  const NetworkFailure(this.message);
  
  @override
  String toString() => 'Network error: $message';
}

class CacheFailure extends Failure {
  final String message;
  
  const CacheFailure(this.message);
  
  @override
  String toString() => 'Cache error: $message';
}

class AuthFailure extends Failure {
  final String message;
  
  const AuthFailure(this.message);
  
  @override
  String toString() => 'Authorization error: $message';
}
