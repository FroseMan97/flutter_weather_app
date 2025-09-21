import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_core/errors/exceptions.dart';
import 'package:weather_domain/weather_domain.dart';

import 'usecases_test.mocks.dart';

@GenerateMocks([CitiesRepository, WeatherRepository])
void main() {
  group('SearchCitiesUseCase', () {
    late SearchCitiesUseCase useCase;
    late MockCitiesRepository mockRepository;

    setUp(() {
      mockRepository = MockCitiesRepository();
      useCase = SearchCitiesUseCase(mockRepository);
    });

    test('should return cities when repository returns data', () async {
      // Arrange
      const query = 'London';
      final cities = [
        const City(
          name: 'London',
          countryCode: 'GB',
          iataCode: 'LHR',
          stateCode: 'ENG',
          latitude: 51.5,
          longitude: -0.1,
        ),
      ];
      when(mockRepository.searchCities(query)).thenAnswer((_) async => cities);

      // Act
      final result = await useCase(query);

      // Assert
      expect(result, equals(cities));
      verify(mockRepository.searchCities(query)).called(1);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      const query = 'Invalid';
      when(mockRepository.searchCities(query))
          .thenThrow(const NetworkException('Network error'));

      // Act & Assert
      expect(() => useCase(query), throwsA(isA<NetworkException>()));
      verify(mockRepository.searchCities(query)).called(1);
    });
  });

  group('GetWeatherUseCase', () {
    late GetWeatherUseCase useCase;
    late MockWeatherRepository mockRepository;

    setUp(() {
      mockRepository = MockWeatherRepository();
      useCase = GetWeatherUseCase(mockRepository);
    });

    test('should return weather when repository returns data', () async {
      // Arrange
      const cityName = 'London';
      const locale = 'en';
      final weather = Weather(
        cityName: cityName,
        temperature: 25.0,
        description: 'sunny',
        icon: '01d',
        feelsLike: 24.0,
        humidity: 70,
        windSpeed: 10.0,
        dateTime: DateTime.now(),
      );
      when(mockRepository.getCurrentWeather(cityName, locale))
          .thenAnswer((_) async => weather);

      // Act
      final result = await useCase(cityName, locale);

      // Assert
      expect(result, equals(weather));
      verify(mockRepository.getCurrentWeather(cityName, locale)).called(1);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      const cityName = 'Invalid';
      const locale = 'en';
      when(mockRepository.getCurrentWeather(cityName, locale))
          .thenThrow(const ServerException('Server error'));

      // Act & Assert
      expect(() => useCase(cityName, locale), throwsA(isA<ServerException>()));
      verify(mockRepository.getCurrentWeather(cityName, locale)).called(1);
    });
  });
}
