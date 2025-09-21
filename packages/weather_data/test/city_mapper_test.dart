import 'package:flutter_test/flutter_test.dart';
import 'package:weather_data/weather_data.dart';

void main() {
  group('CityMapper', () {
    late CityMapper mapper;

    setUp(() {
      mapper = CityMapper();
    });

    test('should map LocationData to City correctly with all fields', () {
      // Arrange
      final locationData = LocationData(
        name: 'London',
        type: 'CITY',
        subType: 'CITY',
        iataCode: 'LHR',
        address: Address(countryCode: 'GB', stateCode: 'ENG'),
        geoCode: GeoCode(latitude: 51.5, longitude: -0.1),
      );

      // Act
      final city = mapper.toEntity(locationData);

      // Assert
      expect(city.name, 'London');
      expect(city.countryCode, 'GB');
      expect(city.iataCode, 'LHR');
      expect(city.stateCode, 'ENG');
      expect(city.latitude, 51.5);
      expect(city.longitude, -0.1);
    });

    test('should handle null fields gracefully with default values', () {
      // Arrange
      final locationData = LocationData(
        name: null,
        type: null,
        subType: null,
        iataCode: null,
        address: null,
        geoCode: null,
      );

      // Act
      final city = mapper.toEntity(locationData);

      // Assert
      expect(city.name, '');
      expect(city.countryCode, '');
      expect(city.iataCode, '');
      expect(city.stateCode, '');
      expect(city.latitude, 0.0);
      expect(city.longitude, 0.0);
    });

    test('should clean city name by removing trailing commas and spaces', () {
      // Arrange
      final locationData = LocationData(
        name: 'London, ',
        type: 'CITY',
        subType: 'CITY',
        iataCode: 'LHR',
        address: Address(countryCode: 'GB', stateCode: 'ENG'),
        geoCode: GeoCode(latitude: 51.5, longitude: -0.1),
      );

      // Act
      final city = mapper.toEntity(locationData);

      // Assert
      expect(city.name, 'London');
    });

    test('should clean city name with multiple trailing commas', () {
      // Arrange
      final locationData = LocationData(
        name: 'New York, , ',
        type: 'CITY',
        subType: 'CITY',
        iataCode: 'NYC',
        address: Address(countryCode: 'US', stateCode: 'NY'),
        geoCode: GeoCode(latitude: 40.7, longitude: -74.0),
      );

      // Act
      final city = mapper.toEntity(locationData);

      // Assert
      expect(city.name, 'New York');
    });

    test('should clean city name with various trailing comma patterns', () {
      // Test different patterns of trailing commas
      final testCases = [
        'Paris, ',
        'Tokyo, , ',
        'Berlin, , , ',
        'Madrid,  ,  ',
        'Rome, , , , ',
      ];

      for (final testName in testCases) {
        final locationData = LocationData(
          name: testName,
          type: 'CITY',
          subType: 'CITY',
          iataCode: 'TEST',
          address: Address(countryCode: 'XX', stateCode: 'XX'),
          geoCode: GeoCode(latitude: 0.0, longitude: 0.0),
        );

        final city = mapper.toEntity(locationData);
        
        // Extract the expected clean name (everything before the first comma)
        final expectedName = testName.split(',')[0].trim();
        expect(city.name, expectedName, reason: 'Failed for input: "$testName"');
      }
    });

    test('should handle partial null address fields', () {
      // Arrange
      final locationData = LocationData(
        name: 'Paris',
        type: 'CITY',
        subType: 'CITY',
        iataCode: 'CDG',
        address: Address(countryCode: 'FR', stateCode: null),
        geoCode: GeoCode(latitude: 48.9, longitude: 2.3),
      );

      // Act
      final city = mapper.toEntity(locationData);

      // Assert
      expect(city.name, 'Paris');
      expect(city.countryCode, 'FR');
      expect(city.stateCode, '');
      expect(city.latitude, 48.9);
      expect(city.longitude, 2.3);
    });

    test('should handle partial null geoCode fields', () {
      // Arrange
      final locationData = LocationData(
        name: 'Tokyo',
        type: 'CITY',
        subType: 'CITY',
        iataCode: 'NRT',
        address: Address(countryCode: 'JP', stateCode: '13'),
        geoCode: GeoCode(latitude: 35.7, longitude: null),
      );

      // Act
      final city = mapper.toEntity(locationData);

      // Assert
      expect(city.name, 'Tokyo');
      expect(city.countryCode, 'JP');
      expect(city.stateCode, '13');
      expect(city.latitude, 35.7);
      expect(city.longitude, 0.0);
    });
  });
}
