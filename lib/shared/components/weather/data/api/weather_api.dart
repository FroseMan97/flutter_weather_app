import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/localization/app_localization.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/weather_model.dart';
import '../models/weather_search_params.dart';

@injectable
class WeatherApi {
  final Dio _dio;

  WeatherApi(this._dio);

  Future<WeatherModel> getCurrentWeather(WeatherSearchParams params) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.weatherBaseUrl}${ApiConstants.weatherEndpoint}',
        queryParameters: {
          'q': params.cityName,
          'appid': ApiConstants.weatherApiKey,
          'units': params.units,
          'lang': params.language,
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw ServerException(AppLocalization.failedToGetWeatherData);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(AppLocalization.networkTimeout);
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(AppLocalization.noInternetConnection);
      } else {
        throw ServerException('${AppLocalization.failedToGetWeatherData}: ${e.message}');
      }
    } catch (e) {
      throw ServerException('${AppLocalization.unexpectedError}: $e');
    }
  }
}
