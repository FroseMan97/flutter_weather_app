import 'package:flutter/material.dart';
import 'package:flutter_weather_app/localization/app_localization.dart';

class WeatherLoadingWidget extends StatelessWidget {
  const WeatherLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(AppLocalization.loadingWeather),
          ],
        ),
      ),
    );
  }
}
