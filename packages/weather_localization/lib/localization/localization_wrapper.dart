import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalizationWrapper extends StatelessWidget {
  final Widget child;

  const LocalizationWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      path: 'packages/weather_localization/assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: child,
    );
  }
}