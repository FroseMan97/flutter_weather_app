import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_cubit.dart';
import '../bloc/weather_state.dart';
import 'weather_initial_widget.dart';
import 'weather_loading_widget.dart';
import 'weather_loaded_widget.dart';
import 'weather_error_widget.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return state.when(
          initial: () => const WeatherInitialWidget(),
          loading: () => const WeatherLoadingWidget(),
          loaded: (weather) => WeatherLoadedWidget(weather: weather),
          error: (message) => WeatherErrorWidget(message: message),
        );
      },
    );
  }

}
