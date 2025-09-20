import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/domain/usecases/search_cities_usecase.dart';
import 'package:flutter_weather_app/core/errors/error_handler.dart';
import 'package:injectable/injectable.dart';
import 'cities_state.dart';

@injectable
class CitiesCubit extends Cubit<CitiesState> {
  final SearchCitiesUseCase _searchCitiesUseCase;
  Timer? _debounceTimer;

  CitiesCubit(this._searchCitiesUseCase) : super(const CitiesState.initial());

  void searchCities(String query, {String? cityNameOnlyLettersMessage}) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      emit(const CitiesState.empty());
      return;
    }

    if (query.length < 3) {
      emit(const CitiesState.empty());
      return;
    }

    // Show suggestions immediately when user starts typing
    if (state is CitiesLoaded) {
      final currentState = state as CitiesLoaded;
      emit(currentState.copyWith(showSuggestions: true));
    }

    // Debounce search by 500ms
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    emit(const CitiesState.loading());

    final result = await _searchCitiesUseCase(query);
    
    result.fold(
      (failure) {
        ErrorHandler.logError('Cities search failed', failure);
        emit(CitiesState.error(failure.toString()));
      },
      (cities) {
        if (cities.isEmpty) {
          emit(const CitiesState.empty());
        } else {
          emit(CitiesState.loaded(
            cities: cities, 
            showSuggestions: true,
          ));
        }
      },
    );
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    emit(const CitiesState.initial());
  }

  void showSuggestions() {
    if (state is CitiesLoaded) {
      final currentState = state as CitiesLoaded;
      emit(currentState.copyWith(showSuggestions: true));
    }
  }

  void hideSuggestions() {
    if (state is CitiesLoaded) {
      final currentState = state as CitiesLoaded;
      emit(currentState.copyWith(showSuggestions: false));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
