import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'E-08', screenName: 'Order Detail');
}
