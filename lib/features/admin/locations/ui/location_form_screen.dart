import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class LocationFormScreen extends StatelessWidget {
  final String? locationId;
  const LocationFormScreen({super.key, this.locationId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'H-17', screenName: 'Location Form');
}
