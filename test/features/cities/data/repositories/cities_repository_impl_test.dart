import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/shared/components/cities/data/datasources/cities_local_datasource.dart';
import 'package:flutter_weather_app/shared/components/cities/data/datasources/cities_remote_datasource.dart';
import 'package:flutter_weather_app/shared/components/cities/data/mappers/city_mapper.dart';
import 'package:flutter_weather_app/shared/components/cities/data/models/city_model.dart';
import 'package:flutter_weather_app/shared/components/cities/data/repositories/cities_repository_impl.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/entities/city.dart';

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
        type: 'location',
        subType: 'city',
        name: 'London',
        iataCode: 'LHR',
        address: Address(
          countryCode: 'GB',
          stateCode: 'GB-ENG',
        ),
        geoCode: GeoCode(
          latitude: 51.5074,
          longitude: -0.1278,
        ),
      ),
      CityData(
        type: 'location',
        subType: 'city',
        name: 'London',
        iataCode: 'YXU',
        address: Address(
          countryCode: 'CA',
          stateCode: 'CA-ON',
        ),
        geoCode: GeoCode(
          latitude: 42.9849,
          longitude: -81.2453,
        ),
      ),
    ];

    test('должен возвращать кешированные данные при наличии', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => testCityDataList);

      // Действие
      final result = await repository.searchCities(testQuery);

      // Проверка
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (cities) {
          expect(cities.length, equals(2));
          expect(cities[0].name, equals('London'));
          expect(cities[0].countryCode, equals('GB'));
        },
      );
      verify(mockLocalDataSource.getCachedCities(testQuery)).called(1);
      verifyNever(mockRemoteDataSource.searchCities(any));
    });

    test('должен возвращать список сущностей City при успешном вызове удаленного источника данных', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => <CityData>[]);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenAnswer((_) async => testCityDataList);
      when(mockLocalDataSource.cacheCities(testQuery, testCityDataList))
          .thenAnswer((_) async {});

      // Действие
      final result = await repository.searchCities(testQuery);

      // Проверка
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (cities) {
          expect(cities.length, equals(2));
          expect(cities[0].name, equals('London'));
          expect(cities[0].countryCode, equals('GB'));
          expect(cities[0].iataCode, equals('LHR'));
          expect(cities[0].stateCode, equals('GB-ENG'));
          expect(cities[0].latitude, equals(51.5074));
          expect(cities[0].longitude, equals(-0.1278));
        },
      );

      verify(mockRemoteDataSource.searchCities(testQuery)).called(1);
    });

    test('должен возвращать пустой список когда удаленный источник данных возвращает пустой список', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => <CityData>[]);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenAnswer((_) async => <CityData>[]);
      when(mockLocalDataSource.cacheCities(testQuery, <CityData>[]))
          .thenAnswer((_) async {});

      // Действие
      final result = await repository.searchCities(testQuery);

      // Проверка
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (cities) => expect(cities.isEmpty, isTrue),
      );

      verify(mockRemoteDataSource.searchCities(testQuery)).called(1);
    });

    test('должен возвращать ServerFailure при ServerException от удаленного источника данных', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => <CityData>[]);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(const ServerException('Server error'));

      // Действие
      final result = await repository.searchCities(testQuery);

      // Проверка
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (cities) => fail('Не должен возвращать города'),
      );
    });

    test('должен возвращать кешированные данные при NetworkException', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => testCityDataList);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(const NetworkException('Network error'));

      // Действие
      final result = await repository.searchCities(testQuery);

      // Проверка
      expect(result, isA<Right<Failure, List<City>>>());
      result.fold(
        (failure) => fail('Должен возвращать кешированные данные'),
        (cities) {
          expect(cities.length, equals(2));
          expect(cities[0].name, equals('London'));
        },
      );
    });

    test('должен возвращать AuthFailure при AuthException от удаленного источника данных', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => <CityData>[]);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(const AuthException('Auth error'));

      // Действие
      final result = await repository.searchCities(testQuery);

      // Проверка
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (cities) => fail('Не должен возвращать города'),
      );
    });

    test('должен возвращать ServerFailure при CacheException от удаленного источника данных', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => <CityData>[]);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(const CacheException('Cache error'));

      // Действие
      final result = await repository.searchCities(testQuery);

      // Проверка
      expect(result, isA<Left<Failure, List<City>>>());
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (cities) => fail('Не должен возвращать города'),
      );
    });

  });
}
