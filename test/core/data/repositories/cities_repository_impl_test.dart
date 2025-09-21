import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/core/data/datasources/cities_local_datasource.dart';
import 'package:flutter_weather_app/core/data/datasources/cities_remote_datasource.dart';
import 'package:flutter_weather_app/core/data/mappers/city_mapper.dart';
import 'package:flutter_weather_app/core/data/models/city_model.dart';
import 'package:flutter_weather_app/core/data/repositories/cities_repository_impl.dart';

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
      const CityData(
        name: 'London',
        iataCode: 'LHR',
        stateCode: 'GB-ENG',
        countryCode: 'GB',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
      const CityData(
        name: 'London',
        iataCode: 'STN',
        stateCode: 'GB-ENG',
        countryCode: 'GB',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
    ];

    test('должен возвращать кешированные города когда они есть в кеше', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => testCityDataList);
      final testCities = testCityDataList.map((data) => cityMapper.toEntity(data)).toList();

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, equals(testCities));
      expect(result.length, equals(2));
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
      final testCities = testCityDataList.map((data) => cityMapper.toEntity(data)).toList();

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, equals(testCities));
      expect(result.length, equals(2));
      verify(mockLocalDataSource.getCachedCities(testQuery));
      verify(mockRemoteDataSource.searchCities(testQuery));
      verify(mockLocalDataSource.cacheCities(testQuery, testCityDataList));
    });

    test('должен пробрасывать ServerException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(ServerException('Сервер недоступен'));

      // Act & Assert
      expect(
        () => repository.searchCities(testQuery),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Сервер недоступен',
        )),
      );
    });

    test('должен возвращать кешированные города при NetworkException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => testCityDataList);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(NetworkException('Нет интернета'));
      final testCities = testCityDataList.map((data) => cityMapper.toEntity(data)).toList();

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, equals(testCities));
      expect(result.length, equals(2));
      verify(mockLocalDataSource.getCachedCities(testQuery));
      verify(mockRemoteDataSource.searchCities(testQuery));
    });

    test('должен пробрасывать NetworkException при пустом кеше', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(NetworkException('Нет интернета'));

      // Act & Assert
      expect(
        () => repository.searchCities(testQuery),
        throwsA(isA<NetworkException>().having(
          (e) => e.message,
          'message',
          'Нет интернета',
        )),
      );
    });

    test('должен пробрасывать AuthException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(AuthException('Неверный API ключ'));

      // Act & Assert
      expect(
        () => repository.searchCities(testQuery),
        throwsA(isA<AuthException>().having(
          (e) => e.message,
          'message',
          'Неверный API ключ',
        )),
      );
    });

    test('должен пробрасывать неожиданную ошибку', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCities(testQuery))
          .thenAnswer((_) async => []);
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(Exception('Неожиданная ошибка'));

      // Act & Assert
      expect(
        () => repository.searchCities(testQuery),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Неожиданная ошибка'),
        )),
      );
    });
  });
}