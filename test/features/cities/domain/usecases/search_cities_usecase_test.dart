import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/entities/city.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/repositories/cities_repository.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/usecases/search_cities_usecase.dart';

import 'search_cities_usecase_test.mocks.dart';

@GenerateMocks([CitiesRepository])
void main() {
  late SearchCitiesUseCase useCase;
  late MockCitiesRepository mockRepository;

  setUp(() {
    mockRepository = MockCitiesRepository();
    useCase = SearchCitiesUseCase(mockRepository);
  });

  group('SearchCitiesUseCase', () {
    const testQuery = 'London';
    final testCities = [
      City(
        name: 'London',
        countryCode: 'GB',
        iataCode: 'LHR',
        stateCode: 'England',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
    ];

    test('должен возвращать города при успешном вызове репозитория', () async {
      // Подготовка
      when(mockRepository.searchCities(testQuery))
          .thenAnswer((_) async => Right(testCities));

      // Действие
      final result = await useCase(testQuery);

      // Проверка
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (cities) {
          expect(cities, equals(testCities));
          expect(cities.length, equals(1));
          expect(cities[0].name, equals('London'));
        },
      );
      verify(mockRepository.searchCities(testQuery)).called(1);
    });

    test('должен возвращать ValidationFailure при пустом запросе', () async {
      // Действие
      final result = await useCase('');

      // Проверка
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Query cannot be empty'));
        },
        (cities) => fail('Не должен возвращать города'),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен возвращать ValidationFailure при слишком коротком запросе', () async {
      // Действие
      final result = await useCase('Lo');

      // Проверка
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Query must be at least 3 characters'));
        },
        (cities) => fail('Не должен возвращать города'),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен возвращать ValidationFailure при недопустимых символах в запросе', () async {
      // Действие
      final result = await useCase('London123');

      // Проверка
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Query can only contain letters and spaces'));
        },
        (cities) => fail('Не должен возвращать города'),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен возвращать ValidationFailure при специальных символах в запросе', () async {
      // Действие
      final result = await useCase('London@#\$');

      // Проверка
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Query can only contain letters and spaces'));
        },
        (cities) => fail('Не должен возвращать города'),
      );
      verifyNever(mockRepository.searchCities(any));
    });

    test('должен разрешать пробелы в запросе', () async {
      // Подготовка
      when(mockRepository.searchCities('New York'))
          .thenAnswer((_) async => Right(testCities));

      // Действие
      final result = await useCase('New York');

      // Проверка
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (cities) => expect(cities, equals(testCities)),
      );
      verify(mockRepository.searchCities('New York')).called(1);
    });

    test('должен возвращать ошибку при неудачном вызове репозитория', () async {
      // Подготовка
      when(mockRepository.searchCities(testQuery))
          .thenAnswer((_) async => const Left(NetworkFailure('Network error')));

      // Действие
      final result = await useCase(testQuery);

      // Проверка
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.toString(), contains('Network error'));
        },
        (cities) => fail('Не должен возвращать города'),
      );
      verify(mockRepository.searchCities(testQuery)).called(1);
    });
  });
}
