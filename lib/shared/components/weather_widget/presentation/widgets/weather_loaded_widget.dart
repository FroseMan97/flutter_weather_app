import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/localization/app_localization.dart';
import '../../domain/entities/weather.dart';
import '../bloc/weather_cubit.dart';

class WeatherLoadedWidget extends StatelessWidget {
  final Weather weather;

  const WeatherLoadedWidget({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.cityName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      weather.description.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    _buildWeatherIcon(context),
                    Text(
                      '${weather.temperature.toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail(
                  icon: Icons.thermostat,
                  label: AppLocalization.feelsLike,
                  value: '${weather.feelsLike.toStringAsFixed(1)}°C',
                ),
                _buildWeatherDetail(
                  icon: Icons.water_drop,
                  label: AppLocalization.humidity,
                  value: '${weather.humidity}%',
                ),
                _buildWeatherDetail(
                  icon: Icons.air,
                  label: AppLocalization.wind,
                  value: '${weather.windSpeed.toStringAsFixed(1)} ${AppLocalization.mps}',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${AppLocalization.updated}: ${_formatDateTime(weather.dateTime)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherIcon(BuildContext context) {
    return Image.network(
      context.read<WeatherCubit>().getWeatherIconUrl(weather.icon),
      width: 80,
      height: 80,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.wb_sunny,
          size: 80,
          color: Colors.orange,
        );
      },
    );
  }

  Widget _buildWeatherDetail({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade600),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
