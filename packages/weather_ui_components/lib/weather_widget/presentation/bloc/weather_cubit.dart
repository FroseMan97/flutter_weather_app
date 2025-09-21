
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_core/weather_core.dart';
import 'package:weather_domain/weather_domain.dart';
import 'weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;

  WeatherCubit(this._getWeatherUseCase) : super(const WeatherState.initial());

  Future<void> getCurrentWeather(String cityName, String locale) async {
    emit(WeatherState.loading());

    try {
      
      final weather = await _getWeatherUseCase(cityName, locale);
      emit(WeatherState.loaded(weather));
    } catch (e) {
      ErrorHandler.logError('Weather fetch failed', e);
      emit(WeatherState.error(e.toString(), cityName: cityName, locale: locale));
    }
  }

  void clearWeather() {
    emit(const WeatherState.initial());
  }

  /// Повторяет последний запрос погоды (если есть сохраненные параметры)
  Future<void> retryLastRequest() async {
    final currentState = state;
    if (currentState is WeatherError && currentState.cityName != null && currentState.locale != null) {
      await getCurrentWeather(currentState.cityName!, currentState.locale!);
    }
  }

  String getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
