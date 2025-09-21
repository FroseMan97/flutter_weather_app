import 'package:flutter_test/flutter_test.dart';
import 'package:weather_core/weather_core.dart' hide test;

void main() {
  group('DioClient', () {
    test('should be created successfully', () {
      expect(() => DioClient(), returnsNormally);
    });

    test('should have dio property', () {
      final client = DioClient();
      expect(client.dio, isNotNull);
    });
  });
}
