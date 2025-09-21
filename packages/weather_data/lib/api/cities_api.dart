import 'package:weather_core/weather_core.dart';
import 'package:weather_localization/weather_localization.dart';
import '../data/models/city_model.dart';

class CitiesApi {
  final DioClient _dioClient;
  String? _accessToken;
  DateTime? _tokenExpiry;

  CitiesApi(this._dioClient);

  Future<CitiesResponse> searchCities(String query) async {
    try {
      // Получаем access token
      final accessToken = await _getAccessToken();
      
      final response = await _dioClient.dio.get(
        '${ApiConstants.amadeusBaseUrl}/reference-data/locations/cities',
        queryParameters: {
          'keyword': query,
          'max': 10,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return CitiesResponse.fromJson(response.data);
      } else {
        throw ServerException('${AppLocalization.serverError}: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Токен истек, сбрасываем его и пытаемся получить новый
        _accessToken = null;
        _tokenExpiry = null;
        throw AuthException('${AppLocalization.tokenExpired}: ${e.message}');
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

  /// Принудительно обновляет токен
  Future<void> refreshToken() async {
    _accessToken = null;
    _tokenExpiry = null;
    await _getAccessToken();
  }

  Future<String> _getAccessToken() async {
    // Проверяем, есть ли действующий токен
    if (_accessToken != null && _tokenExpiry != null && DateTime.now().isBefore(_tokenExpiry!)) {
      ErrorHandler.logInfo('Using cached access token');
      return _accessToken!;
    }

    ErrorHandler.logInfo('Getting new access token');

    try {
      final response = await _dioClient.dio.post(
        '${ApiConstants.amadeusBaseUrl}/security/oauth2/token',
        data: {
          'grant_type': 'client_credentials',
          'client_id': ApiConstants.amadeusApiKey,
          'client_secret': ApiConstants.amadeusApiSecret,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        _accessToken = response.data['access_token'];
        // Токен Amadeus действует 30 минут, но обновляем за 5 минут до истечения
        _tokenExpiry = DateTime.now().add(const Duration(minutes: 25));
        ErrorHandler.logInfo('Access token obtained, expires at: $_tokenExpiry');
        return _accessToken!;
      } else {
        throw AuthException('${AppLocalization.failedToGetAccessToken}: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw AuthException('${AppLocalization.authError}: ${e.message}');
    } catch (e) {
      throw ServerException('${AppLocalization.unexpectedError}: $e');
    }
  }
}

