import 'package:weather_core/weather_core.dart';
import 'package:weather_localization/weather_localization.dart';
import '../data/models/weather_model.dart' as model;

class WeatherApi {
  final DioClient _dioClient;

  WeatherApi(this._dioClient);

  Future<model.WeatherModel> getCurrentWeather(String cityName, String lang) async {
    try {
      final response = await _dioClient.dio.get(
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
        throw ServerException('${AppLocalization.serverError}: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthException('${AppLocalization.authError}: ${e.message}');
      } else if (e.response?.statusCode == 404) {
        throw ServerException('${AppLocalization.citiesNotFound}: ${e.message}');
      } else if (e.type == DioExceptionType.connectionTimeout ||
                 e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('${AppLocalization.networkTimeout}: ${e.message}');
      } else {
        throw NetworkException('${AppLocalization.networkError}: ${e.message}');
      }
    } catch (e) {
      throw ServerException('${AppLocalization.unexpectedError}: $e');
    }
  }
}


