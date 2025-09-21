import 'package:flutter_test/flutter_test.dart';
import 'package:weather_core/weather_core.dart' hide test;

void main() {
  group('ErrorHandler', () {
    test('logInfo should not throw', () {
      expect(() => ErrorHandler.logInfo('Test info message'), returnsNormally);
    });

    test('logWarning should not throw', () {
      expect(() => ErrorHandler.logWarning('Test warning message'), returnsNormally);
    });

    test('logError should not throw with message only', () {
      expect(() => ErrorHandler.logError('Test error message'), returnsNormally);
    });

    test('logError should not throw with error and stackTrace', () {
      final error = Exception('Test exception');
      final stackTrace = StackTrace.current;
      expect(() => ErrorHandler.logError('Test error message', error, stackTrace), returnsNormally);
    });
  });
}
