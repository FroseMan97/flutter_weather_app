// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_weather_app/core/di/dio_module.dart' as _i687;
import 'package:flutter_weather_app/shared/components/cities/data/api/cities_api.dart'
    as _i702;
import 'package:flutter_weather_app/shared/components/cities/data/datasources/cities_remote_datasource.dart'
    as _i831;
import 'package:flutter_weather_app/shared/components/cities/data/mappers/city_mapper.dart'
    as _i190;
import 'package:flutter_weather_app/shared/components/cities/data/repositories/cities_repository_impl.dart'
    as _i898;
import 'package:flutter_weather_app/shared/components/cities/di/cities_module.dart'
    as _i824;
import 'package:flutter_weather_app/shared/components/cities/domain/repositories/cities_repository.dart'
    as _i635;
import 'package:flutter_weather_app/shared/components/cities/presentation/bloc/cities_cubit.dart'
    as _i553;
import 'package:flutter_weather_app/shared/components/weather/data/api/weather_api.dart'
    as _i411;
import 'package:flutter_weather_app/shared/components/weather/data/datasources/weather_remote_datasource.dart'
    as _i371;
import 'package:flutter_weather_app/shared/components/weather/data/mappers/weather_mapper.dart'
    as _i961;
import 'package:flutter_weather_app/shared/components/weather/data/repositories/weather_repository_impl.dart'
    as _i777;
import 'package:flutter_weather_app/shared/components/weather/di/weather_module.dart'
    as _i771;
import 'package:flutter_weather_app/shared/components/weather/domain/repositories/weather_repository.dart'
    as _i388;
import 'package:flutter_weather_app/shared/components/weather/presentation/bloc/weather_cubit.dart'
    as _i695;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    final citiesModule = _$CitiesModule();
    final weatherModule = _$WeatherModule();
    gh.factory<_i190.CityMapper>(() => _i190.CityMapper());
    gh.factory<_i961.WeatherMapper>(() => _i961.WeatherMapper());
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i702.CitiesApi>(() => _i702.CitiesApi(gh<_i361.Dio>()));
    gh.factory<_i411.WeatherApi>(() => _i411.WeatherApi(gh<_i361.Dio>()));
    gh.factory<_i831.CitiesRemoteDataSourceImpl>(
        () => _i831.CitiesRemoteDataSourceImpl(gh<_i702.CitiesApi>()));
    gh.factory<_i831.CitiesRemoteDataSource>(() => citiesModule
        .citiesRemoteDataSource(gh<_i831.CitiesRemoteDataSourceImpl>()));
    gh.factory<_i371.WeatherRemoteDataSourceImpl>(
        () => _i371.WeatherRemoteDataSourceImpl(gh<_i411.WeatherApi>()));
    gh.factory<_i898.CitiesRepositoryImpl>(() => _i898.CitiesRepositoryImpl(
          gh<_i831.CitiesRemoteDataSource>(),
          gh<_i190.CityMapper>(),
        ));
    gh.factory<_i371.WeatherRemoteDataSource>(() => weatherModule
        .weatherRemoteDataSource(gh<_i371.WeatherRemoteDataSourceImpl>()));
    gh.factory<_i635.CitiesRepository>(
        () => citiesModule.citiesRepository(gh<_i898.CitiesRepositoryImpl>()));
    gh.factory<_i777.WeatherRepositoryImpl>(() => _i777.WeatherRepositoryImpl(
          gh<_i371.WeatherRemoteDataSource>(),
          gh<_i961.WeatherMapper>(),
        ));
    gh.factory<_i388.WeatherRepository>(() =>
        weatherModule.weatherRepository(gh<_i777.WeatherRepositoryImpl>()));
    gh.factory<_i553.CitiesCubit>(
        () => _i553.CitiesCubit(gh<_i635.CitiesRepository>()));
    gh.factory<_i695.WeatherCubit>(
        () => _i695.WeatherCubit(gh<_i388.WeatherRepository>()));
    return this;
  }
}

class _$DioModule extends _i687.DioModule {}

class _$CitiesModule extends _i824.CitiesModule {}

class _$WeatherModule extends _i771.WeatherModule {}
