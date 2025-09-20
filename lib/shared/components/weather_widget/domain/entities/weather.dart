class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final DateTime dateTime;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.dateTime,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Weather &&
        other.cityName == cityName &&
        other.temperature == temperature &&
        other.description == description &&
        other.icon == icon &&
        other.feelsLike == feelsLike &&
        other.humidity == humidity &&
        other.windSpeed == windSpeed &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return Object.hash(
      cityName,
      temperature,
      description,
      icon,
      feelsLike,
      humidity,
      windSpeed,
      dateTime,
    );
  }

  @override
  String toString() {
    return 'Weather(cityName: $cityName, temperature: $temperature, description: $description, icon: $icon, feelsLike: $feelsLike, humidity: $humidity, windSpeed: $windSpeed, dateTime: $dateTime)';
  }
}
