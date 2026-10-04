import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class AdminOrderDetailScreen extends StatelessWidget {
  final String orderId;
  const AdminOrderDetailScreen({super.key, required this.orderId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'H-08', screenName: 'Admin Order Detail');
}
