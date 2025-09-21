import 'package:flutter_test/flutter_test.dart';
import 'package:weather_core/weather_core.dart' hide test;

void main() {
  group('Exceptions', () {
    test('ServerException toString should return message with prefix', () {
      const message = 'Test server error';
      const exception = ServerException(message);
      expect(exception.toString(), contains('serverError'));
      expect(exception.toString(), contains(message));
    });

    test('NetworkException toString should return message with prefix', () {
      const message = 'Test network error';
      const exception = NetworkException(message);
      expect(exception.toString(), contains('networkError'));
      expect(exception.toString(), contains(message));
    });

    test('CacheException toString should return message with prefix', () {
      const message = 'Test cache error';
      const exception = CacheException(message);
      expect(exception.toString(), contains('cacheError'));
      expect(exception.toString(), contains(message));
    });

    test('AuthException toString should return message with prefix', () {
      const message = 'Test auth error';
      const exception = AuthException(message);
      expect(exception.toString(), contains('authError'));
      expect(exception.toString(), contains(message));
    });
  });
}
