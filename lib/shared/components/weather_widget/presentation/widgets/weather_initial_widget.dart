import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_weather_app/core/localization/app_localization.dart';

class WeatherInitialWidget extends StatelessWidget {
  const WeatherInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wb_sunny,
              size: 64,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalization.selectCityForWeather,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
