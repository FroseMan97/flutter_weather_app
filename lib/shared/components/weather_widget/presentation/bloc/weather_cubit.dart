import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/errors/error_handler.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_weather_usecase.dart';
import 'weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;

  WeatherCubit(this._getWeatherUseCase) : super(const WeatherState.initial());

  Future<void> getCurrentWeather(String cityName, String locale) async {
    emit(const WeatherState.loading());

    final result = await _getWeatherUseCase(cityName, locale);
    
    result.fold(
      (failure) {
        ErrorHandler.logError('Weather fetch failed', failure);
        emit(WeatherState.error(failure.toString()));
      },
      (weather) {
        emit(WeatherState.loaded(weather));
      },
    );
  }

  void clearWeather() {
    emit(const WeatherState.initial());
  }

  String getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
