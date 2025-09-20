import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/core/domain/entities/city.dart';
import 'package:flutter_weather_app/core/domain/usecases/search_cities_usecase.dart';
import 'package:flutter_weather_app/shared/components/cities_search_field/presentation/bloc/cities_cubit.dart';
import 'package:flutter_weather_app/shared/components/cities_search_field/presentation/bloc/cities_state.dart';

import 'cities_cubit_test.mocks.dart';

@GenerateMocks([SearchCitiesUseCase])
void main() {
  late CitiesCubit cubit;
  late MockSearchCitiesUseCase mockSearchCitiesUseCase;

  setUp(() {
    mockSearchCitiesUseCase = MockSearchCitiesUseCase();
    cubit = CitiesCubit(mockSearchCitiesUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('CitiesCubit', () {
    test('должен начинать с initial состояния', () {
      expect(cubit.state, equals(const CitiesState.initial()));
    });

    group('searchCities', () {
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

      test('должен эмитить loading состояние при поиске', () async {
        // Arrange
        when(mockSearchCitiesUseCase(testQuery))
            .thenAnswer((_) async => Right(testCities));

        // Act
        cubit.searchCities(testQuery);

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const CitiesState.loading(),
            CitiesState.loaded(cities: testCities, showSuggestions: true),
          ]),
        );
      });

      test('должен эмитить loaded состояние при успешном поиске', () async {
        // Arrange
        when(mockSearchCitiesUseCase(testQuery))
            .thenAnswer((_) async => Right(testCities));

        // Act
        cubit.searchCities(testQuery);

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const CitiesState.loading(),
            CitiesState.loaded(cities: testCities, showSuggestions: true),
          ]),
        );
        verify(mockSearchCitiesUseCase(testQuery));
      });

      test('должен эмитить empty состояние при пустом результате', () async {
        // Arrange
        when(mockSearchCitiesUseCase(testQuery))
            .thenAnswer((_) async => const Right([]));

        // Act
        cubit.searchCities(testQuery);

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const CitiesState.loading(),
            const CitiesState.empty(),
          ]),
        );
      });

      test('должен эмитить error состояние при ошибке', () async {
        // Arrange
        when(mockSearchCitiesUseCase(testQuery))
            .thenAnswer((_) async => const Left(ServerFailure('Ошибка сервера')));

        // Act
        cubit.searchCities(testQuery);

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const CitiesState.loading(),
            const CitiesState.error('ServerFailure: Ошибка сервера'),
          ]),
        );
      });

      test('должен эмитить empty состояние при пустом запросе', () {
        // Act
        cubit.searchCities('');

        // Assert
        expect(cubit.state, equals(const CitiesState.empty()));
        verifyNever(mockSearchCitiesUseCase(any));
      });

      test('должен эмитить empty состояние при коротком запросе', () {
        // Act
        cubit.searchCities('Lo');

        // Assert
        expect(cubit.state, equals(const CitiesState.empty()));
        verifyNever(mockSearchCitiesUseCase(any));
      });
    });

    group('clearSearch', () {
      test('должен эмитить initial состояние', () {
        // Act
        cubit.clearSearch();

        // Assert
        expect(cubit.state, equals(const CitiesState.initial()));
      });
    });

    group('showSuggestions', () {
      test('должен показать предложения когда состояние loaded', () {
        // Arrange
        final testCities = [
          City(
            name: 'London',
            countryCode: 'GB',
            iataCode: 'LHR',
            stateCode: 'GB-ENG',
            latitude: 51.5074,
            longitude: -0.1278,
          ),
        ];
        cubit.emit(CitiesState.loaded(cities: testCities, showSuggestions: false));

        // Act
        cubit.showSuggestions();

        // Assert
        expect(cubit.state, equals(CitiesState.loaded(cities: testCities, showSuggestions: true)));
      });
    });

    group('hideSuggestions', () {
      test('должен скрыть предложения когда состояние loaded', () {
        // Arrange
        final testCities = [
          City(
            name: 'London',
            countryCode: 'GB',
            iataCode: 'LHR',
            stateCode: 'GB-ENG',
            latitude: 51.5074,
            longitude: -0.1278,
          ),
        ];
        cubit.emit(CitiesState.loaded(cities: testCities, showSuggestions: true));

        // Act
        cubit.hideSuggestions();

        // Assert
        expect(cubit.state, equals(CitiesState.loaded(cities: testCities, showSuggestions: false)));
      });
    });
  });
}