import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/api_constants.dart';
import '../../data/models/weather_model.dart' as model;

@injectable
class WeatherApi {
  final Dio _dio;

  WeatherApi(this._dio);

  Future<model.WeatherModel> getCurrentWeather(String cityName, String lang) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.weatherBaseUrl}/weather',
        queryParameters: {
          'q': cityName,
          'appid': ApiConstants.weatherApiKey,
          'units': 'metric',
          'lang': lang,
        },
      );

      if (response.statusCode == 200) {
        return model.WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get weather: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: Check your API key');
      } else if (e.response?.statusCode == 404) {
        throw Exception('City not found: $cityName');
      } else if (e.type == DioExceptionType.connectionTimeout ||
                 e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Network timeout: Please check your connection');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
