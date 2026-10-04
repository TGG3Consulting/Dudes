import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_spacing.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      if (!mounted) return;
      context.go('/home');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool('onboarding_done') ?? false;

    if (!mounted) return;
    if (done) {
      context.go('/login');
    } else {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.content_cut,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: AppSpacing.s4),
            Text(
              "Dude's",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'Barber Shop',
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 4,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.s14),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
