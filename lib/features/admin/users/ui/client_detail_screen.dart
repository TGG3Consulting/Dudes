import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class ClientDetailScreen extends StatelessWidget {
  final String clientId;
  const ClientDetailScreen({super.key, required this.clientId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'H-03', screenName: 'Client Detail');
}
