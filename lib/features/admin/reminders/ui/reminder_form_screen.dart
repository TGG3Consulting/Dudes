import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class ReminderFormScreen extends StatelessWidget {
  final String? reminderId;
  const ReminderFormScreen({super.key, this.reminderId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'H-15', screenName: 'Reminder Form');
}
