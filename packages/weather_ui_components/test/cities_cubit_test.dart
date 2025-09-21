import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_core/errors/exceptions.dart';
import 'package:weather_ui_components/weather_ui_components.dart';
import 'package:weather_domain/weather_domain.dart';

import 'cities_cubit_test.mocks.dart';

@GenerateMocks([SearchCitiesUseCase])
void main() {
  group('CitiesCubit', () {
    late CitiesCubit cubit;
    late MockSearchCitiesUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockSearchCitiesUseCase();
      cubit = CitiesCubit(mockUseCase);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state should be CitiesState.initial', () {
      expect(cubit.state, const CitiesState.initial());
    });

    group('searchCities', () {
      blocTest<CitiesCubit, CitiesState>(
        'emits [loading, loaded] when search is successful',
        build: () {
          when(mockUseCase(any)).thenAnswer((_) async => [
            const City(
              name: 'London',
              countryCode: 'GB',
              iataCode: 'LHR',
              stateCode: 'ENG',
              latitude: 51.5,
              longitude: -0.1,
            ),
          ]);
          return cubit;
        },
        act: (cubit) => cubit.searchCities('London'),
        wait: const Duration(milliseconds: 600), // Wait for debounce
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.loaded(
            cities: [
              City(
                name: 'London',
                countryCode: 'GB',
                iataCode: 'LHR',
                stateCode: 'ENG',
                latitude: 51.5,
                longitude: -0.1,
              ),
            ],
            showSuggestions: true,
          ),
        ],
        verify: (_) {
          verify(mockUseCase('London')).called(1);
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [loading, empty] when search returns empty results',
        build: () {
          when(mockUseCase(any)).thenAnswer((_) async => []);
          return cubit;
        },
        act: (cubit) => cubit.searchCities('NonExistentCity'),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.empty(),
        ],
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [loading, error] when search throws exception',
        build: () {
          when(mockUseCase(any)).thenThrow(const NetworkException('Network error'));
          return cubit;
        },
        act: (cubit) => cubit.searchCities('ErrorCity'),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          const CitiesState.loading(),
          const CitiesState.error('networkError: Network error'),
        ],
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [empty] when query is too short',
        build: () => cubit,
        act: (cubit) => cubit.searchCities('Lo'),
        expect: () => [const CitiesState.empty()],
        verify: (_) {
          verifyNever(mockUseCase(any));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [empty] when query is empty',
        build: () => cubit,
        act: (cubit) => cubit.searchCities(''),
        expect: () => [const CitiesState.empty()],
        verify: (_) {
          verifyNever(mockUseCase(any));
        },
      );
    });

    group('clearSearch', () {
      blocTest<CitiesCubit, CitiesState>(
        'emits [initial] when clearSearch is called',
        build: () => cubit,
        act: (cubit) => cubit.clearSearch(),
        expect: () => [const CitiesState.initial()],
      );
    });
  });
}
