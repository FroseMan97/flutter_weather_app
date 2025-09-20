// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_weather_app/core/di/app_module.dart' as _i687;
import 'package:flutter_weather_app/shared/components/cities_search_field/data/api/cities_api.dart'
    as _i702;
import 'package:flutter_weather_app/shared/components/cities_search_field/data/datasources/cities_local_datasource.dart'
    as _i969;
import 'package:flutter_weather_app/shared/components/cities_search_field/data/datasources/cities_remote_datasource.dart'
    as _i831;
import 'package:flutter_weather_app/shared/components/cities_search_field/data/mappers/city_mapper.dart'
    as _i190;
import 'package:flutter_weather_app/shared/components/cities_search_field/data/repositories/cities_repository_impl.dart'
    as _i898;
import 'package:flutter_weather_app/shared/components/cities_search_field/domain/repositories/cities_repository.dart'
    as _i635;
import 'package:flutter_weather_app/shared/components/cities_search_field/domain/usecases/search_cities_usecase.dart'
    as _i942;
import 'package:flutter_weather_app/shared/components/cities_search_field/presentation/bloc/cities_cubit.dart'
    as _i553;
import 'package:flutter_weather_app/shared/components/weather_widget/data/api/weather_api.dart'
    as _i411;
import 'package:flutter_weather_app/shared/components/weather_widget/data/datasources/weather_local_datasource.dart'
    as _i815;
import 'package:flutter_weather_app/shared/components/weather_widget/data/datasources/weather_remote_datasource.dart'
    as _i371;
import 'package:flutter_weather_app/shared/components/weather_widget/data/mappers/weather_mapper.dart'
    as _i961;
import 'package:flutter_weather_app/shared/components/weather_widget/data/repositories/weather_repository_impl.dart'
    as _i777;
import 'package:flutter_weather_app/shared/components/weather_widget/domain/repositories/weather_repository.dart'
    as _i388;
import 'package:flutter_weather_app/shared/components/weather_widget/domain/usecases/get_weather_usecase.dart'
    as _i1055;
import 'package:flutter_weather_app/shared/components/weather_widget/presentation/bloc/weather_cubit.dart'
    as _i695;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i190.CityMapper>(() => _i190.CityMapper());
    gh.factory<_i961.WeatherMapper>(() => _i961.WeatherMapper());
    gh.singleton<_i361.Dio>(() => appModule.dio);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i702.CitiesApi>(() => _i702.CitiesApi(gh<_i361.Dio>()));
    gh.factory<_i411.WeatherApi>(() => _i411.WeatherApi(gh<_i361.Dio>()));
    gh.factory<_i969.CitiesLocalDataSourceImpl>(
        () => _i969.CitiesLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.factory<_i815.WeatherLocalDataSourceImpl>(
        () => _i815.WeatherLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.factory<_i831.CitiesRemoteDataSourceImpl>(
        () => _i831.CitiesRemoteDataSourceImpl(gh<_i702.CitiesApi>()));
    gh.singleton<_i969.CitiesLocalDataSource>(() => appModule
        .citiesLocalDataSource(gh<_i969.CitiesLocalDataSourceImpl>()));
    gh.singleton<_i831.CitiesRemoteDataSource>(() => appModule
        .citiesRemoteDataSource(gh<_i831.CitiesRemoteDataSourceImpl>()));
    gh.factory<_i898.CitiesRepositoryImpl>(() => _i898.CitiesRepositoryImpl(
          gh<_i831.CitiesRemoteDataSource>(),
          gh<_i969.CitiesLocalDataSource>(),
          gh<_i190.CityMapper>(),
        ));
    gh.factory<_i371.WeatherRemoteDataSourceImpl>(
        () => _i371.WeatherRemoteDataSourceImpl(gh<_i411.WeatherApi>()));
    gh.singleton<_i815.WeatherLocalDataSource>(() => appModule
        .weatherLocalDataSource(gh<_i815.WeatherLocalDataSourceImpl>()));
    gh.singleton<_i635.CitiesRepository>(
        () => appModule.citiesRepository(gh<_i898.CitiesRepositoryImpl>()));
    gh.factory<_i942.SearchCitiesUseCase>(
        () => _i942.SearchCitiesUseCase(gh<_i635.CitiesRepository>()));
    gh.singleton<_i371.WeatherRemoteDataSource>(() => appModule
        .weatherRemoteDataSource(gh<_i371.WeatherRemoteDataSourceImpl>()));
    gh.factory<_i777.WeatherRepositoryImpl>(() => _i777.WeatherRepositoryImpl(
          gh<_i371.WeatherRemoteDataSource>(),
          gh<_i815.WeatherLocalDataSource>(),
          gh<_i961.WeatherMapper>(),
        ));
    gh.factory<_i553.CitiesCubit>(
        () => _i553.CitiesCubit(gh<_i942.SearchCitiesUseCase>()));
    gh.singleton<_i388.WeatherRepository>(() =>
        appModule.weatherRepository(gh<_i777.WeatherRepositoryImpl>()));
    gh.factory<_i1055.GetWeatherUseCase>(
        () => _i1055.GetWeatherUseCase(gh<_i388.WeatherRepository>()));
    gh.factory<_i695.WeatherCubit>(
        () => _i695.WeatherCubit(gh<_i1055.GetWeatherUseCase>()));
    return this;
  }
}

class _$AppModule extends _i687.AppModule {}
