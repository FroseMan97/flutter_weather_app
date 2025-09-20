import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/core/data/datasources/cities_local_datasource.dart';
import 'package:flutter_weather_app/core/data/datasources/cities_remote_datasource.dart';
import 'package:flutter_weather_app/core/data/mappers/city_mapper.dart';
import 'package:flutter_weather_app/core/data/models/city_model.dart';
import 'package:flutter_weather_app/core/data/repositories/cities_repository_impl.dart';
import 'package:flutter_weather_app/core/domain/entities/city.dart';

import 'cities_repository_impl_test.mocks.dart';

@GenerateMocks([CitiesRemoteDataSource, CitiesLocalDataSource])
void main() {
  late CitiesRepositoryImpl repository;
  late MockCitiesRemoteDataSource mockRemoteDataSource;
  late MockCitiesLocalDataSource mockLocalDataSource;
  late CityMapper cityMapper;

  setUp(() {
    mockRemoteDataSource = MockCitiesRemoteDataSource();
    mockLocalDataSource = MockCitiesLocalDataSource();
    cityMapper = CityMapper();
    repository = CitiesRepositoryImpl(mockRemoteDataSource, mockLocalDataSource, cityMapper);
  });

  group('searchCities', () {
    const testQuery = 'London';
    final testCityDataList = [
      CityData(
        name: 'London',
        iataCode: 'LHR',
        stateCode: 'GB-ENG',
        countryCode: 'GB',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
      CityData(
        name: 'London',
        iataCode: 'STN',
        stateCode: 'GB-ENG',
        countryCode: 'GB',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
    ];

    final testCities = testCityDataList.map((data) => cityMapper.toEntity(data)).toList();

    test('должен возвращать кешированные города когда они есть в кеше', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => testCityDataList);

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (cities) {
          expect(cities, equals(testCities));
          expect(cities.length, equals(2));
        },
      );
      verify(mockLocalDataSource.getCachedCities(testQuery));
      verifyNever(mockRemoteDataSource.searchCities(any));
    });

    test('должен получать города из API и кешировать их когда кеш пуст', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenAnswer((_) async => testCityDataList);
      when(mockLocalDataSource.cacheCities(testQuery, testCityDataList))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (cities) {
          expect(cities, equals(testCities));
          expect(cities.length, equals(2));
        },
      );
      verify(mockLocalDataSource.getCachedCities(testQuery));
      verify(mockRemoteDataSource.searchCities(testQuery));
      verify(mockLocalDataSource.cacheCities(testQuery, testCityDataList));
    });

    test('должен возвращать ServerFailure при ServerException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(ServerException('Сервер недоступен'));

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.toString(), contains('Сервер недоступен'));
        },
        (cities) => fail('Не должно быть городов'),
      );
    });

    test('должен возвращать кешированные города при NetworkException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => testCityDataList);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(NetworkException('Нет интернета'));

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (cities) {
          expect(cities, equals(testCities));
          expect(cities.length, equals(2));
        },
      );
      verify(mockLocalDataSource.getCachedCities(testQuery));
      verify(mockRemoteDataSource.searchCities(testQuery));
    });

    test('должен возвращать NetworkFailure при NetworkException и пустом кеше', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(NetworkException('Нет интернета'));

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.toString(), contains('Нет интернета'));
        },
        (cities) => fail('Не должно быть городов'),
      );
    });

    test('должен возвращать AuthFailure при AuthException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(AuthException('Неверный API ключ'));

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          expect(failure.toString(), contains('Неверный API ключ'));
        },
        (cities) => fail('Не должно быть городов'),
      );
    });

    test('должен возвращать ServerFailure при неожиданной ошибке', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(Exception('Неожиданная ошибка'));

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.toString(), contains('Неожиданная ошибка'));
        },
        (cities) => fail('Не должно быть городов'),
      );
    });
  });
}