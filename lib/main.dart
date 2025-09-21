import 'package:flutter/material.dart';
import 'package:weather_localization/weather_localization.dart';
import 'di/injection.dart';
import 'app_features/weather_by_city_screen/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  runApp(
    LocalizationWrapper(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);
    return MaterialApp(
      title: AppLocalization.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const WeatherPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
