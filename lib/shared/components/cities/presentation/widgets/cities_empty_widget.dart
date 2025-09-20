import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CitiesEmptyWidget extends StatelessWidget {
  const CitiesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('citiesNotFound'.tr()),
    );
  }
}
