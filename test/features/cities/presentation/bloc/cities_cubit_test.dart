import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/entities/city.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/usecases/search_cities_usecase.dart';
import 'package:flutter_weather_app/shared/components/cities/presentation/bloc/cities_cubit.dart';
import 'package:flutter_weather_app/shared/components/cities/presentation/bloc/cities_state.dart';

import 'cities_cubit_test.mocks.dart';

@GenerateMocks([SearchCitiesUseCase])
void main() {
  late MockSearchCitiesUseCase mockSearchCitiesUseCase;
  late CitiesCubit citiesCubit;

  setUp(() {
    mockSearchCitiesUseCase = MockSearchCitiesUseCase();
    citiesCubit = CitiesCubit(mockSearchCitiesUseCase);
  });

  tearDown(() {
    citiesCubit.close();
  });

  group('CitiesCubit', () {
    test('initial state should be CitiesInitial', () {
      expect(citiesCubit.state, equals(const CitiesState.initial()));
    });

    group('searchCities', () {
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
        City(
          name: 'London',
          countryCode: 'CA',
          iataCode: 'YXU',
          stateCode: 'Ontario',
          latitude: 42.9849,
          longitude: -81.2453,
        ),
      ];

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesLoaded] when searchCities succeeds with results',
        build: () {
          when(mockSearchCitiesUseCase(testQuery))
              .thenAnswer((_) async => Right(testCities));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities(testQuery),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          CitiesState.loaded(cities: testCities, showSuggestions: true),
        ],
        verify: (_) {
          verify(mockSearchCitiesUseCase(testQuery)).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesEmpty] when searchCities succeeds with no results',
        build: () {
          when(mockSearchCitiesUseCase(testQuery))
              .thenAnswer((_) async => const Right(<City>[]));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities(testQuery),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.empty(),
        ],
        verify: (_) {
          verify(mockSearchCitiesUseCase(testQuery)).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesError] when searchCities fails',
        build: () {
          when(mockSearchCitiesUseCase(testQuery))
              .thenAnswer((_) async => const Left(NetworkFailure('Network error')));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities(testQuery),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.error('Network error: Network error'),
        ],
        verify: (_) {
          verify(mockSearchCitiesUseCase(testQuery)).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesEmpty] when query is empty',
        build: () => citiesCubit,
        act: (cubit) => cubit.searchCities(''),
        expect: () => [
          const CitiesState.empty(),
        ],
        verify: (_) {
          verifyNever(mockSearchCitiesUseCase(any));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesEmpty] when query is too short (1 character)',
        build: () => citiesCubit,
        act: (cubit) => cubit.searchCities('L'),
        expect: () => [
          const CitiesState.empty(),
        ],
        verify: (_) {
          verifyNever(mockSearchCitiesUseCase(any));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesEmpty] when query is too short (2 characters)',
        build: () => citiesCubit,
        act: (cubit) => cubit.searchCities('Lo'),
        expect: () => [
          const CitiesState.empty(),
        ],
        verify: (_) {
          verifyNever(mockSearchCitiesUseCase(any));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesError] when query contains numbers',
        build: () {
          when(mockSearchCitiesUseCase('London123'))
              .thenAnswer((_) async => const Left(ValidationFailure('Query can only contain letters and spaces')));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities('London123'),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.error('Validation error: Query can only contain letters and spaces'),
        ],
        verify: (_) {
          verify(mockSearchCitiesUseCase('London123')).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesLoaded] when query contains spaces (valid)',
        build: () {
          when(mockSearchCitiesUseCase('New York'))
              .thenAnswer((_) async => Right(testCities));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities('New York'),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          const CitiesState.loading(),
          CitiesState.loaded(cities: testCities, showSuggestions: true),
        ],
        verify: (_) {
          verify(mockSearchCitiesUseCase('New York')).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesError] when query contains special characters',
        build: () {
          when(mockSearchCitiesUseCase('London@#\$'))
              .thenAnswer((_) async => const Left(ValidationFailure('Query can only contain letters and spaces')));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities('London@#\$'),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.error('Validation error: Query can only contain letters and spaces'),
        ],
        verify: (_) {
          verify(mockSearchCitiesUseCase('London@#\$')).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesLoaded] when query contains only letters (3+ characters)',
        build: () {
          when(mockSearchCitiesUseCase('Lon'))
              .thenAnswer((_) async => Right(testCities));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities('Lon'),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          CitiesState.loaded(cities: testCities, showSuggestions: true),
        ],
        verify: (_) {
          verify(mockSearchCitiesUseCase('Lon')).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesLoaded] when query contains only letters (longer name)',
        build: () {
          when(mockSearchCitiesUseCase('London'))
              .thenAnswer((_) async => Right(testCities));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities('London'),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          CitiesState.loaded(cities: testCities, showSuggestions: true),
        ],
        verify: (_) {
          verify(mockSearchCitiesUseCase('London')).called(1);
        },
      );
    });

    group('clearSearch', () {
      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesInitial] when clearSearch is called',
        build: () => citiesCubit,
        act: (cubit) => cubit.clearSearch(),
        expect: () => [
          const CitiesState.initial(),
        ],
      );
    });
  });
}
