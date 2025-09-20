import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/localization/app_localization.dart';
import '../bloc/weather_cubit.dart';

class WeatherErrorWidget extends StatelessWidget {
  final String message;

  const WeatherErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalization.error,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red.shade600),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<WeatherCubit>().clearWeather(),
            child: Text(AppLocalization.tryAgain),
          ),
        ],
      ),
    );
  }
}
