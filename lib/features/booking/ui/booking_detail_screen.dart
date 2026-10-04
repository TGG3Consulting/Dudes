import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class BookingDetailScreen extends StatelessWidget {
  final String id;
  const BookingDetailScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'D-07', screenName: 'Booking Detail');
}
