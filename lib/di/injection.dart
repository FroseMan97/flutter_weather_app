import 'package:weather_core/weather_core.dart';
import 'package:weather_data/weather_data.dart';
import 'package:weather_domain/weather_domain.dart';
import 'package:weather_ui_components/weather_ui_components.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Регистрируем базовые зависимости (singleton)
  getIt.registerSingleton<Dio>(Dio());
  
  // Инициализируем SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  // Регистрируем DioClient (singleton)
  getIt.registerSingleton<DioClient>(DioClient());
  
  // Регистрируем API (singleton)
  getIt.registerSingleton<CitiesApi>(CitiesApi(getIt<DioClient>()));
  getIt.registerSingleton<WeatherApi>(WeatherApi(getIt<DioClient>()));
  
  // Регистрируем data sources (singleton) - используем ленивую инициализацию
  getIt.registerSingleton<CitiesRemoteDataSource>(CitiesRemoteDataSourceImpl(getIt<CitiesApi>()));
  getIt.registerSingleton<CitiesLocalDataSource>(CitiesLocalDataSourceImpl(sharedPreferences));
  getIt.registerSingleton<WeatherRemoteDataSource>(WeatherRemoteDataSourceImpl(getIt<WeatherApi>()));
  getIt.registerSingleton<WeatherLocalDataSource>(WeatherLocalDataSourceImpl(sharedPreferences));
  
  // Регистрируем репозитории (singleton)
  getIt.registerSingleton<CitiesRepository>(CitiesRepositoryImpl(
    getIt<CitiesRemoteDataSource>(),
    getIt<CitiesLocalDataSource>(),
    CityMapper(),
  ));
  getIt.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(
    getIt<WeatherRemoteDataSource>(),
    getIt<WeatherLocalDataSource>(),
    WeatherMapper(),
  ));
  
  // Регистрируем use cases (singleton)
  getIt.registerSingleton<SearchCitiesUseCase>(SearchCitiesUseCase(getIt<CitiesRepository>()));
  getIt.registerSingleton<GetWeatherUseCase>(GetWeatherUseCase(getIt<WeatherRepository>()));
  
  // Регистрируем cubits (factory - каждый раз новый экземпляр)
  getIt.registerFactory<CitiesCubit>(() => CitiesCubit(getIt<SearchCitiesUseCase>()));
  getIt.registerFactory<WeatherCubit>(() => WeatherCubit(getIt<GetWeatherUseCase>()));
}

