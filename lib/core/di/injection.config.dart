// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_weather_app/shared/data/api/cities_api.dart' as _i949;
import 'package:flutter_weather_app/shared/data/api/weather_api.dart' as _i562;
import 'package:flutter_weather_app/shared/data/datasources/cities_local_datasource.dart'
    as _i522;
import 'package:flutter_weather_app/shared/data/datasources/cities_remote_datasource.dart'
    as _i714;
import 'package:flutter_weather_app/shared/data/datasources/weather_local_datasource.dart'
    as _i187;
import 'package:flutter_weather_app/shared/data/datasources/weather_remote_datasource.dart'
    as _i1048;
import 'package:flutter_weather_app/shared/data/mappers/city_mapper.dart'
    as _i954;
import 'package:flutter_weather_app/shared/data/mappers/weather_mapper.dart'
    as _i747;
import 'package:flutter_weather_app/shared/data/repositories/cities_repository_impl.dart'
    as _i888;
import 'package:flutter_weather_app/shared/data/repositories/weather_repository_impl.dart'
    as _i803;
import 'package:flutter_weather_app/core/di/app_module.dart' as _i779;
import 'package:flutter_weather_app/shared/domain/repositories/cities_repository.dart'
    as _i185;
import 'package:flutter_weather_app/shared/domain/repositories/weather_repository.dart'
    as _i722;
import 'package:flutter_weather_app/shared/domain/usecases/get_weather_usecase.dart'
    as _i311;
import 'package:flutter_weather_app/shared/domain/usecases/search_cities_usecase.dart'
    as _i720;
import 'package:flutter_weather_app/shared/components/cities_search_field/presentation/bloc/cities_cubit.dart'
    as _i703;
import 'package:flutter_weather_app/shared/components/weather_widget/presentation/bloc/weather_cubit.dart'
    as _i329;
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
    gh.factory<_i954.CityMapper>(() => _i954.CityMapper());
    gh.factory<_i747.WeatherMapper>(() => _i747.WeatherMapper());
    gh.singleton<_i361.Dio>(() => appModule.dio);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i949.CitiesApi>(() => _i949.CitiesApi(gh<_i361.Dio>()));
    gh.factory<_i562.WeatherApi>(() => _i562.WeatherApi(gh<_i361.Dio>()));
    gh.factory<_i714.CitiesRemoteDataSourceImpl>(
        () => _i714.CitiesRemoteDataSourceImpl(gh<_i949.CitiesApi>()));
    gh.factory<_i522.CitiesLocalDataSourceImpl>(
        () => _i522.CitiesLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.factory<_i187.WeatherLocalDataSourceImpl>(
        () => _i187.WeatherLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.singleton<_i187.WeatherLocalDataSource>(() => appModule
        .weatherLocalDataSource(gh<_i187.WeatherLocalDataSourceImpl>()));
    gh.singleton<_i714.CitiesRemoteDataSource>(() => appModule
        .citiesRemoteDataSource(gh<_i714.CitiesRemoteDataSourceImpl>()));
    gh.factory<_i1048.WeatherRemoteDataSourceImpl>(
        () => _i1048.WeatherRemoteDataSourceImpl(gh<_i562.WeatherApi>()));
    gh.singleton<_i1048.WeatherRemoteDataSource>(() => appModule
        .weatherRemoteDataSource(gh<_i1048.WeatherRemoteDataSourceImpl>()));
    gh.singleton<_i522.CitiesLocalDataSource>(() =>
        appModule.citiesLocalDataSource(gh<_i522.CitiesLocalDataSourceImpl>()));
    gh.factory<_i888.CitiesRepositoryImpl>(() => _i888.CitiesRepositoryImpl(
          gh<_i714.CitiesRemoteDataSource>(),
          gh<_i522.CitiesLocalDataSource>(),
          gh<_i954.CityMapper>(),
        ));
    gh.singleton<_i185.CitiesRepository>(
        () => appModule.citiesRepository(gh<_i888.CitiesRepositoryImpl>()));
    gh.factory<_i803.WeatherRepositoryImpl>(() => _i803.WeatherRepositoryImpl(
          gh<_i1048.WeatherRemoteDataSource>(),
          gh<_i187.WeatherLocalDataSource>(),
          gh<_i747.WeatherMapper>(),
        ));
    gh.factory<_i720.SearchCitiesUseCase>(
        () => _i720.SearchCitiesUseCase(gh<_i185.CitiesRepository>()));
    gh.factory<_i703.CitiesCubit>(
        () => _i703.CitiesCubit(gh<_i720.SearchCitiesUseCase>()));
    gh.singleton<_i722.WeatherRepository>(
        () => appModule.weatherRepository(gh<_i803.WeatherRepositoryImpl>()));
    gh.factory<_i311.GetWeatherUseCase>(
        () => _i311.GetWeatherUseCase(gh<_i722.WeatherRepository>()));
    gh.factory<_i329.WeatherCubit>(
        () => _i329.WeatherCubit(gh<_i311.GetWeatherUseCase>()));
    return this;
  }
}

class _$AppModule extends _i779.AppModule {}
