import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'A-01', screenName: 'Splash');
}
