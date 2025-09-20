import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/localization/app_localization.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/weather_repository.dart';
import 'weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(const WeatherState.initial());

  Future<void> getCurrentWeather(String cityName, String locale) async {
    if (cityName.isEmpty) {
      emit(WeatherState.error(AppLocalization.pleaseEnterCityName));
      return;
    }

    emit(const WeatherState.loading());

    try {
      final weather = await _weatherRepository.getCurrentWeather(cityName, locale);
      emit(WeatherState.loaded(weather));
    } catch (e) {
      emit(WeatherState.error(e.toString()));
    }
  }

  void clearWeather() {
    emit(const WeatherState.initial());
  }

  String getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
