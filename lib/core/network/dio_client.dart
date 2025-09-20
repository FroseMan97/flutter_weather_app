import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'retry_interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  DioClient._internal();

  late final Dio _dio;
  final Logger _logger = Logger();

  void initialize() {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ));

    // Добавляем retry interceptor
    _dio.interceptors.add(RetryInterceptor());

    // Добавляем логирование
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => _logger.d(obj),
    ));
  }

  Dio get dio => _dio;
}
