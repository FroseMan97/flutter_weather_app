import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weather_core/errors/exceptions.dart';
import 'package:weather_ui_components/weather_ui_components.dart';
import 'package:weather_domain/weather_domain.dart';

// Mock class without mockito
class MockSearchCitiesUseCase implements SearchCitiesUseCase {
  List<City>? _citiesToReturn;
  Exception? _exceptionToThrow;
  int _callCount = 0;
  String? _lastQuery;

  void setCitiesToReturn(List<City> cities) {
    _citiesToReturn = cities;
  }

  void setExceptionToThrow(Exception exception) {
    _exceptionToThrow = exception;
  }

  int get callCount => _callCount;
  String? get lastQuery => _lastQuery;

  @override
  Future<List<City>> call(String query) async {
    _callCount++;
    _lastQuery = query;
    if (_exceptionToThrow != null) {
      throw _exceptionToThrow!;
    }
    return _citiesToReturn ?? [];
  }
}

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
          mockUseCase.setCitiesToReturn([
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
          expect(mockUseCase.callCount, equals(1));
          expect(mockUseCase.lastQuery, equals('London'));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [loading, empty] when search returns empty results',
        build: () {
          mockUseCase.setCitiesToReturn([]);
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
          mockUseCase.setExceptionToThrow(const NetworkException('Network error'));
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
          expect(mockUseCase.callCount, equals(0));
        },
      );

      blocTest<CitiesCubit, CitiesState>(
        'emits [empty] when query is empty',
        build: () => cubit,
        act: (cubit) => cubit.searchCities(''),
        expect: () => [const CitiesState.empty()],
        verify: (_) {
          expect(mockUseCase.callCount, equals(0));
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
