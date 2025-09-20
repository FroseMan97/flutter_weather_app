import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/shared/components/cities/data/datasources/cities_remote_datasource.dart';
import 'package:flutter_weather_app/shared/components/cities/data/mappers/city_mapper.dart';
import 'package:flutter_weather_app/shared/components/cities/data/models/city_model.dart';
import 'package:flutter_weather_app/shared/components/cities/data/repositories/cities_repository_impl.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/entities/city.dart';

import 'cities_repository_impl_test.mocks.dart';

@GenerateMocks([CitiesRemoteDataSource])
void main() {
  late CitiesRepositoryImpl repository;
  late MockCitiesRemoteDataSource mockRemoteDataSource;
  late CityMapper cityMapper;

  setUp(() {
    mockRemoteDataSource = MockCitiesRemoteDataSource();
    cityMapper = CityMapper();
    repository = CitiesRepositoryImpl(mockRemoteDataSource, cityMapper);
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

    test('should return list of City entities when remote data source is successful', () async {
      // Arrange
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenAnswer((_) async => testCityDataList);

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<List<City>>());
      expect(result.length, equals(2));
      expect(result[0].name, equals('London'));
      expect(result[0].countryCode, equals('GB'));
      expect(result[0].iataCode, equals('LHR'));
      expect(result[0].stateCode, equals('GB-ENG'));
      expect(result[0].latitude, equals(51.5074));
      expect(result[0].longitude, equals(-0.1278));

      verify(mockRemoteDataSource.searchCities(testQuery)).called(1);
    });

    test('should return empty list when remote data source returns empty list', () async {
      // Arrange
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenAnswer((_) async => <CityData>[]);

      // Act
      final result = await repository.searchCities(testQuery);

      // Assert
      expect(result, isA<List<City>>());
      expect(result.isEmpty, isTrue);

      verify(mockRemoteDataSource.searchCities(testQuery)).called(1);
    });

    test('should throw ServerFailure when remote data source throws ServerException', () async {
      // Arrange
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(const ServerException('Server error'));

      // Act & Assert
      expect(
        () => repository.searchCities(testQuery),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('should throw NetworkFailure when remote data source throws NetworkException', () async {
      // Arrange
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(const NetworkException('Network error'));

      // Act & Assert
      expect(
        () => repository.searchCities(testQuery),
        throwsA(isA<NetworkFailure>()),
      );
    });

    test('should throw AuthFailure when remote data source throws AuthException', () async {
      // Arrange
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(const AuthException('Auth error'));

      // Act & Assert
      expect(
        () => repository.searchCities(testQuery),
        throwsA(isA<AuthFailure>()),
      );
    });

    test('should throw ServerFailure when remote data source throws CacheException', () async {
      // Arrange
      when(mockRemoteDataSource.searchCities(testQuery))
          .thenThrow(const CacheException('Cache error'));

      // Act & Assert
      expect(
        () => repository.searchCities(testQuery),
        throwsA(isA<ServerFailure>()),
      );
    });

  });
}
