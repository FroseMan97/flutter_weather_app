import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'failures.dart';

class ErrorHandler {
  static final Logger _logger = Logger();

  static void handleError(BuildContext context, Failure failure) {
    _logger.e('Error occurred: ${failure.toString()}');
    
    String message;
    switch (failure.runtimeType) {
      case NetworkFailure:
        message = 'Проблема с интернет-соединением. Проверьте подключение.';
        break;
      case ServerFailure:
        message = 'Ошибка сервера. Попробуйте позже.';
        break;
      case AuthFailure:
        message = 'Ошибка авторизации. Проверьте API ключи.';
        break;
      case CacheFailure:
        message = 'Ошибка кеширования.';
        break;
      case ValidationFailure:
        message = failure.toString().replaceFirst('Validation error: ', '');
        break;
      default:
        message = 'Произошла неизвестная ошибка.';
    }

    _showErrorSnackBar(context, message);
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Закрыть',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void logInfo(String message) {
    _logger.i(message);
  }

  static void logWarning(String message) {
    _logger.w(message);
  }

  static void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

