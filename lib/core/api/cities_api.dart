import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/api_constants.dart';
import '../../data/models/city_model.dart';

@injectable
class CitiesApi {
  final Dio _dio;

  CitiesApi(this._dio);

  Future<List<CityData>> searchCities(String query) async {
    try {
      // Получаем access token
      final accessToken = await _getAccessToken();
      
      final response = await _dio.get(
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
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => CityData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search cities: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: Check your API credentials');
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

  Future<String> _getAccessToken() async {
    try {
      final response = await _dio.post(
        '${ApiConstants.amadeusBaseUrl}/v1/security/oauth2/token',
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
        return response.data['access_token'];
      } else {
        throw Exception('Failed to get access token: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to authenticate: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during authentication: $e');
    }
  }
}
