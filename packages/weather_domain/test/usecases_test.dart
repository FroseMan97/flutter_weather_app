import 'package:flutter_test/flutter_test.dart';
import 'package:weather_core/errors/exceptions.dart';
import 'package:weather_domain/weather_domain.dart';

// Mock classes without mockito
class MockCitiesRepository implements CitiesRepository {
  List<City>? _citiesToReturn;
  Exception? _exceptionToThrow;
  int _callCount = 0;

  void setCitiesToReturn(List<City> cities) {
    _citiesToReturn = cities;
  }

  void setExceptionToThrow(Exception exception) {
    _exceptionToThrow = exception;
  }

  int get callCount => _callCount;

  @override
  Future<List<City>> searchCities(String query) async {
    _callCount++;
    if (_exceptionToThrow != null) {
      throw _exceptionToThrow!;
    }
    return _citiesToReturn ?? [];
  }
}

class MockWeatherRepository implements WeatherRepository {
  Weather? _weatherToReturn;
  Exception? _exceptionToThrow;
  int _callCount = 0;

  void setWeatherToReturn(Weather weather) {
    _weatherToReturn = weather;
  }

  void setExceptionToThrow(Exception exception) {
    _exceptionToThrow = exception;
  }

  int get callCount => _callCount;

  @override
  Future<Weather> getCurrentWeather(String cityName, String locale) async {
    _callCount++;
    if (_exceptionToThrow != null) {
      throw _exceptionToThrow!;
    }
    if (_weatherToReturn == null) {
      throw const ServerException('No weather data');
    }
    return _weatherToReturn!;
  }
}

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
      mockRepository.setCitiesToReturn(cities);

      // Act
      final result = await useCase(query);

      // Assert
      expect(result, equals(cities));
      expect(mockRepository.callCount, equals(1));
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      const query = 'Invalid';
      mockRepository.setExceptionToThrow(const NetworkException('Network error'));

      // Act & Assert
      expect(() => useCase(query), throwsA(isA<NetworkException>()));
      expect(mockRepository.callCount, equals(1));
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
      mockRepository.setWeatherToReturn(weather);

      // Act
      final result = await useCase(cityName, locale);

      // Assert
      expect(result, equals(weather));
      expect(mockRepository.callCount, equals(1));
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      const cityName = 'Invalid';
      const locale = 'en';
      mockRepository.setExceptionToThrow(const ServerException('Server error'));

      // Act & Assert
      expect(() => useCase(cityName, locale), throwsA(isA<ServerException>()));
      expect(mockRepository.callCount, equals(1));
    });
  });
}
