import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RetryInterceptor extends Interceptor {
  final Logger _logger = Logger();
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
      
      if (retryCount < maxRetries) {
        _logger.w('Retrying request (${retryCount + 1}/$maxRetries): ${err.requestOptions.uri}');
        
        await Future.delayed(retryDelay * (retryCount + 1));
        
        try {
          final response = await Dio().fetch(err.requestOptions.copyWith(
            extra: {...err.requestOptions.extra, 'retryCount': retryCount + 1},
          ));
          
          handler.resolve(response);
          return;
        } catch (e) {
          if (e is DioException) {
            err = e;
          } else {
            err = DioException(
              requestOptions: err.requestOptions,
              error: e,
              type: DioExceptionType.unknown,
            );
          }
        }
      }
    }
    
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError ||
           (err.response?.statusCode != null && 
            err.response!.statusCode! >= 500);
  }
}

