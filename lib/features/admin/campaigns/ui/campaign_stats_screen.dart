import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class CampaignStatsScreen extends StatelessWidget {
  final String campaignId;
  const CampaignStatsScreen({super.key, required this.campaignId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'H-13b', screenName: 'Campaign Stats');
}
