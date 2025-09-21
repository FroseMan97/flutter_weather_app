import 'package:flutter/material.dart';
import 'package:weather_domain/weather_domain.dart';
import 'package:weather_localization/weather_localization.dart';
import 'package:weather_ui_components/weather_ui_components.dart';
import '../../di/injection.dart';

// По идее лучше сделать экранный кубит, который бы менеджил кубиты компонентов
// Но функционал не большой, поэтому опустим

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CitiesCubit>(
          create: (context) => getIt<CitiesCubit>(),
        ),
        BlocProvider<WeatherCubit>(
          create: (context) => getIt<WeatherCubit>(),
        ),
      ],
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  void _onCitySelected(City city) {
    context.read<WeatherCubit>().getCurrentWeather(
      city.name,
      context.locale.languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(AppLocalization.appTitle).tr(),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (Locale locale) {
              context.setLocale(locale);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<Locale>(
                value: Locale('ru', 'RU'),
                child: Row(
                  children: [
                    Text('🇷🇺'),
                    SizedBox(width: 8),
                    Text('Русский'),
                  ],
                ),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('en', 'US'),
                child: Row(
                  children: [
                    Text('🇺🇸'),
                    SizedBox(width: 8),
                    Text('English'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade600,
              Colors.blue.shade300,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CitySearchField(
                      onCitySelected: _onCitySelected,
                      onClearSearch: () {
                        context.read<WeatherCubit>().clearWeather();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: WeatherDisplay(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

