import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/localization/app_localization.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/cities_repository.dart';
import 'cities_state.dart';

@injectable
class CitiesCubit extends Cubit<CitiesState> {
  final CitiesRepository _citiesRepository;
  Timer? _debounceTimer;

  CitiesCubit(this._citiesRepository) : super(const CitiesState.initial());

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

    // Проверяем, что query содержит только буквы
    final validQueryPattern = RegExp(r'^[a-zA-Zа-яА-Я]+$');
    if (!validQueryPattern.hasMatch(query.trim())) {
      emit(CitiesState.error(cityNameOnlyLettersMessage ?? AppLocalization.cityNameOnlyLetters));
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

    try {
      final cities = await _citiesRepository.searchCities(query);
      if (cities.isEmpty) {
        emit(const CitiesState.empty());
      } else {
        emit(CitiesState.loaded(
          cities: cities, 
          showSuggestions: true,
        ));
      }
    } catch (e) {
      emit(CitiesState.error(e.toString()));
    }
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
