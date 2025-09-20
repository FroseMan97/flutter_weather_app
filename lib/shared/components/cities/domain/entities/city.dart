class City {
  final String name;
  final String countryCode;
  final String? iataCode;
  final String? stateCode;
  final double latitude;
  final double longitude;

  const City({
    required this.name,
    required this.countryCode,
    this.iataCode,
    this.stateCode,
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City &&
        other.name == name &&
        other.countryCode == countryCode &&
        other.iataCode == iataCode &&
        other.stateCode == stateCode &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return Object.hash(name, countryCode, iataCode, stateCode, latitude, longitude);
  }

  @override
  String toString() {
    return 'City(name: $name, countryCode: $countryCode, iataCode: $iataCode, stateCode: $stateCode, latitude: $latitude, longitude: $longitude)';
  }
}
