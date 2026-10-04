import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class BonusAdjustmentScreen extends StatelessWidget {
  final String clientId;
  const BonusAdjustmentScreen({super.key, required this.clientId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'H-04', screenName: 'Bonus Adjustment');
}
