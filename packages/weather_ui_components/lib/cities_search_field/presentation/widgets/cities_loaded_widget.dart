import 'package:flutter/material.dart';
import 'package:weather_domain/weather_domain.dart';

class CitiesLoadedWidget extends StatelessWidget {
  final List<City> cities;
  final Function(City) onCitySelected;

  const CitiesLoadedWidget({
    super.key,
    required this.cities,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Позволяет ListView занимать только необходимое место
      physics: const ClampingScrollPhysics(), // Включаем скролл для длинных списков
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return ListTile(
          dense: true,
          title: Text(
            city.name,
            style: const TextStyle(fontSize: 14),
          ),
            subtitle: Text(
              '${city.countryCode}, ${city.stateCode}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          onTap: () => onCitySelected(city),
        );
      },
    );
  }
}
