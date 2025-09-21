import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/shared/domain/entities/city.dart';
import 'package:flutter_weather_app/shared/domain/repositories/cities_repository.dart';
import 'package:flutter_weather_app/shared/domain/usecases/search_cities_usecase.dart';

import 'search_cities_usecase_test.mocks.dart';

@GenerateMocks([CitiesRepository])
void main() {
  late SearchCitiesUseCase useCase;
  late MockCitiesRepository mockRepository;

  setUp(() {
    mockRepository = MockCitiesRepository();
    useCase = SearchCitiesUseCase(mockRepository);
  });

  group('call', () {
    const testQuery = 'London';
    final testCities = [
      const City(
        name: 'London',
        countryCode: 'GB',
        iataCode: 'LHR',
        stateCode: 'GB-ENG',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
      const City(
        name: 'London',
        countryCode: 'GB',
        iataCode: 'STN',
        stateCode: 'GB-ENG',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
    ];

    test('должен возвращать города при успешном поиске', () async {
      // Arrange
      when(mockRepository.searchCities(testQuery))
          .thenAnswer((_) async => testCities);

      // Act
      final result = await useCase(testQuery);

      // Assert
      expect(result, equals(testCities));
      expect(result.length, equals(2));
      verify(mockRepository.searchCities(testQuery));
      verifyNoMoreInteractions(mockRepository);
    });

    test('должен выбрасывать ArgumentError при пустом запросе', () async {
      // Act & Assert
      expect(
        () => useCase(''),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'Query must be at least 3 characters long.',
        )),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен выбрасывать ArgumentError при коротком запросе', () async {
      // Act & Assert
      expect(
        () => useCase('Lo'),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'Query must be at least 3 characters long.',
        )),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен выбрасывать ArgumentError при недопустимых символах', () async {
      // Act & Assert
      expect(
        () => useCase('London@#\$'),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'Query can only contain letters and spaces.',
        )),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен принимать запросы с пробелами', () async {
      // Arrange
      const queryWithSpaces = 'New York';
      when(mockRepository.searchCities(queryWithSpaces))
          .thenAnswer((_) async => testCities);

      // Act
      final result = await useCase(queryWithSpaces);

      // Assert
      expect(result, equals(testCities));
      verify(mockRepository.searchCities(queryWithSpaces));
    });

    test('должен принимать запросы с кириллицей', () async {
      // Arrange
      const cyrillicQuery = 'Москва';
      when(mockRepository.searchCities(cyrillicQuery))
          .thenAnswer((_) async => testCities);

      // Act
      final result = await useCase(cyrillicQuery);

      // Assert
      expect(result, equals(testCities));
      verify(mockRepository.searchCities(cyrillicQuery));
    });

    test('должен пробрасывать ошибку репозитория', () async {
      // Arrange
      when(mockRepository.searchCities(testQuery))
          .thenThrow(Exception('Ошибка сервера'));

      // Act & Assert
      expect(
        () => useCase(testQuery),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Ошибка сервера'),
        )),
      );
      verify(mockRepository.searchCities(testQuery));
    });
  });
}