import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/error_handler.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/domain/usecases/get_weather_usecase.dart';
import 'weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;

  WeatherCubit(this._getWeatherUseCase) : super(const WeatherState.initial());

  Future<void> getCurrentWeather(String cityName, String locale) async {
    emit(const WeatherState.loading());

    try {
      final weather = await _getWeatherUseCase(cityName, locale);
      emit(WeatherState.loaded(weather));
    } catch (e) {
      ErrorHandler.logError('Weather fetch failed', e);
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
