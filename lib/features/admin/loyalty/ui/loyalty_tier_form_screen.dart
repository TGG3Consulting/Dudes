import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class LoyaltyTierFormScreen extends StatelessWidget {
  final String? tierId;
  const LoyaltyTierFormScreen({super.key, this.tierId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'H-18a', screenName: 'Loyalty Tier Form');
}
