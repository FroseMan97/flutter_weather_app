import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/core/domain/entities/city.dart';
import 'package:flutter_weather_app/core/domain/repositories/cities_repository.dart';
import 'package:flutter_weather_app/core/domain/usecases/search_cities_usecase.dart';

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
      City(
        name: 'London',
        countryCode: 'GB',
        iataCode: 'LHR',
        stateCode: 'GB-ENG',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
      City(
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
          .thenAnswer((_) async => Right(testCities));

      // Act
      final result = await useCase(testQuery);

      // Assert
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (cities) {
          expect(cities, equals(testCities));
          expect(cities.length, equals(2));
        },
      );
      verify(mockRepository.searchCities(testQuery));
      verifyNoMoreInteractions(mockRepository);
    });

    test('должен возвращать ValidationFailure при пустом запросе', () async {
      // Act
      final result = await useCase('');

      // Assert
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Query must be at least 3 characters long'));
        },
        (cities) => fail('Не должно быть городов'),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен возвращать ValidationFailure при коротком запросе', () async {
      // Act
      final result = await useCase('Lo');

      // Assert
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Query must be at least 3 characters long'));
        },
        (cities) => fail('Не должно быть городов'),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен возвращать ValidationFailure при недопустимых символах', () async {
      // Act
      final result = await useCase('London@#\$');

      // Assert
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Query can only contain letters and spaces'));
        },
        (cities) => fail('Не должно быть городов'),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен принимать запросы с пробелами', () async {
      // Arrange
      const queryWithSpaces = 'New York';
      when(mockRepository.searchCities(queryWithSpaces))
          .thenAnswer((_) async => Right(testCities));

      // Act
      final result = await useCase(queryWithSpaces);

      // Assert
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (cities) => expect(cities, equals(testCities)),
      );
      verify(mockRepository.searchCities(queryWithSpaces));
    });

    test('должен принимать запросы с кириллицей', () async {
      // Arrange
      const cyrillicQuery = 'Москва';
      when(mockRepository.searchCities(cyrillicQuery))
          .thenAnswer((_) async => Right(testCities));

      // Act
      final result = await useCase(cyrillicQuery);

      // Assert
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (cities) => expect(cities, equals(testCities)),
      );
      verify(mockRepository.searchCities(cyrillicQuery));
    });

    test('должен возвращать ошибку репозитория при неудаче', () async {
      // Arrange
      when(mockRepository.searchCities(testQuery))
          .thenAnswer((_) async => Left(ServerFailure('Ошибка сервера')));

      // Act
      final result = await useCase(testQuery);

      // Assert
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.toString(), contains('Ошибка сервера'));
        },
        (cities) => fail('Не должно быть городов'),
      );
      verify(mockRepository.searchCities(testQuery));
    });
  });
}