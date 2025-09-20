import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/localization/app_localization.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/access_token_model.dart';
import '../models/city_model.dart';
import '../models/cities_search_params.dart';

@injectable
class CitiesApi {
  final Dio _dio;
  AccessTokenModel? _cachedToken;

  CitiesApi(this._dio);

  Future<AccessTokenModel> getAccessToken() async {
    // Return cached token if it's still valid
    if (_cachedToken != null && !_cachedToken!.isExpired) {
      return _cachedToken!;
    }

    try {
      final response = await _dio.post(
        '${ApiConstants.amadeusBaseUrl}${ApiConstants.tokenEndpoint}',
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
        final tokenData = response.data as Map<String, dynamic>;
        final expiresIn = tokenData['expires_in'] as int?;
        _cachedToken = AccessTokenModel(
          accessToken: tokenData['access_token'] as String?,
          tokenType: tokenData['token_type'] as String?,
          expiresIn: expiresIn,
          expiresAt: expiresIn != null 
            ? DateTime.now().add(Duration(seconds: expiresIn))
            : DateTime.now(),
        );
        return _cachedToken!;
      } else {
        throw AuthException(AppLocalization.failedToGetAccessToken);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(AppLocalization.networkTimeout);
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(AppLocalization.noInternetConnection);
      } else {
        throw AuthException('${AppLocalization.failedToGetAccessToken}: ${e.message}');
      }
    } catch (e) {
      throw AuthException('${AppLocalization.unexpectedError}: $e');
    }
  }

  Future<List<CityData>> searchCities(CitiesSearchParams params) async {
    try {
      // Get access token first
      final token = await getAccessToken();

      final response = await _dio.get(
        '${ApiConstants.amadeusBaseUrl}${ApiConstants.citiesSearchEndpoint}',
        queryParameters: {
          'keyword': params.query,
          'max': params.maxResults,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token.accessToken}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final cityResponse = CityResponse.fromJson(response.data);
        return cityResponse.data ?? [];
      } else {
        throw ServerException(AppLocalization.failedToFindCities);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(AppLocalization.networkTimeout);
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(AppLocalization.noInternetConnection);
      } else if (e.response?.statusCode == 401) {
        // Token expired, clear cache and retry
        _cachedToken = null;
        throw AuthException(AppLocalization.tokenExpired);
      } else {
        throw ServerException('${AppLocalization.failedToFindCities}: ${e.message}');
      }
    } catch (e) {
      throw ServerException('${AppLocalization.unexpectedError}: $e');
    }
  }
}
