import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/entities/city.dart';
import 'package:flutter_weather_app/shared/components/cities/domain/repositories/cities_repository.dart';
import 'package:flutter_weather_app/shared/components/cities/presentation/bloc/cities_cubit.dart';
import 'package:flutter_weather_app/shared/components/cities/presentation/bloc/cities_state.dart';

import 'cities_cubit_test.mocks.dart';

@GenerateMocks([CitiesRepository])
void main() {
  late MockCitiesRepository mockCitiesRepository;
  late CitiesCubit citiesCubit;

  setUp(() {
    mockCitiesRepository = MockCitiesRepository();
    citiesCubit = CitiesCubit(mockCitiesRepository);
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
          when(mockCitiesRepository.searchCities(testQuery))
              .thenAnswer((_) async => testCities);
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities(testQuery),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          CitiesState.loaded(cities: testCities, showSuggestions: true),
        ],
        verify: (_) {
          verify(mockCitiesRepository.searchCities(testQuery)).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesEmpty] when searchCities succeeds with no results',
        build: () {
          when(mockCitiesRepository.searchCities(testQuery))
              .thenAnswer((_) async => <City>[]);
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities(testQuery),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.empty(),
        ],
        verify: (_) {
          verify(mockCitiesRepository.searchCities(testQuery)).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesError] when searchCities fails',
        build: () {
          when(mockCitiesRepository.searchCities(testQuery))
              .thenThrow(Exception('Network error'));
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities(testQuery),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.error('Exception: Network error'),
        ],
        verify: (_) {
          verify(mockCitiesRepository.searchCities(testQuery)).called(1);
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
          verifyNever(mockCitiesRepository.searchCities(any));
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
          verifyNever(mockCitiesRepository.searchCities(any));
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
          verifyNever(mockCitiesRepository.searchCities(any));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesError] when query contains numbers',
        build: () => citiesCubit,
        act: (cubit) => cubit.searchCities('London123'),
        expect: () => [
          const CitiesState.error('Название города может содержать только буквы'),
        ],
        verify: (_) {
          verifyNever(mockCitiesRepository.searchCities(any));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesError] when query contains spaces',
        build: () => citiesCubit,
        act: (cubit) => cubit.searchCities('New York'),
        expect: () => [
          const CitiesState.error('Название города может содержать только буквы'),
        ],
        verify: (_) {
          verifyNever(mockCitiesRepository.searchCities(any));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesError] when query contains special characters',
        build: () => citiesCubit,
        act: (cubit) => cubit.searchCities('London@#\$'),
        expect: () => [
          const CitiesState.error('Название города может содержать только буквы'),
        ],
        verify: (_) {
          verifyNever(mockCitiesRepository.searchCities(any));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesLoaded] when query contains only letters (3+ characters)',
        build: () {
          when(mockCitiesRepository.searchCities('Lon'))
              .thenAnswer((_) async => testCities);
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities('Lon'),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          CitiesState.loaded(cities: testCities, showSuggestions: true),
        ],
        verify: (_) {
          verify(mockCitiesRepository.searchCities('Lon')).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [CitiesLoading, CitiesLoaded] when query contains only letters (longer name)',
        build: () {
          when(mockCitiesRepository.searchCities('London'))
              .thenAnswer((_) async => testCities);
          return citiesCubit;
        },
        act: (cubit) => cubit.searchCities('London'),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          CitiesState.loaded(cities: testCities, showSuggestions: true),
        ],
        verify: (_) {
          verify(mockCitiesRepository.searchCities('London')).called(1);
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
