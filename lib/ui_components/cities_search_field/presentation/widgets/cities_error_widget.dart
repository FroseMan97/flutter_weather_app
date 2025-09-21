import 'package:flutter/material.dart';
import '../../../../localization/app_localization.dart';

class CitiesErrorWidget extends StatelessWidget {
  final String message;

  const CitiesErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '${AppLocalization.error}: $message',
        style: TextStyle(color: Colors.red.shade700),
      ),
    );
  }
}
