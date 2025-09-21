import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationWrapper extends StatelessWidget {
  final Widget child;
  const LocalizationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      child: child,
    );
  }
}