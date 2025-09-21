class ApiConstants {
  // OpenWeatherMap API
  static const String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String weatherApiKey = String.fromEnvironment('WEATHER_API_KEY');
  
  // Amadeus API
  static const String amadeusBaseUrl = 'https://test.api.amadeus.com/v1';
  static const String amadeusApiKey = String.fromEnvironment('AMADEUS_API_KEY');
  static const String amadeusApiSecret = String.fromEnvironment('AMADEUS_API_SECRET');
  
  // Endpoints
  static const String weatherEndpoint = '/weather';
  static const String citiesSearchEndpoint = '/reference-data/locations/cities';
  static const String tokenEndpoint = '/security/oauth2/token';
}


