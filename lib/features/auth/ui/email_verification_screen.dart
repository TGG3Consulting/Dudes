import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../domain/auth_provider.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  int _secondsLeft = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _resend(BuildContext context) async {
    setState(() => _secondsLeft = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
        return;
      }
      setState(() => _secondsLeft--);
    });
    final email = ref.read(currentUserProvider)?.email ?? '';
    await ref
        .read(authNotifierProvider.notifier)
        .resendVerificationEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(currentUserProvider, (prev, user) {
      if (user?.emailConfirmedAt != null && mounted) {
        context.go('/home');
      }
    });

    final email = ref.watch(currentUserProvider)?.email ?? '';
    final primary = Theme.of(context).colorScheme.primary;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.s8),
              Icon(Icons.mark_email_unread_outlined, size: 72, color: primary),
              const SizedBox(height: AppSpacing.s6),
              Text(
                'Подтвердите email',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s3),
              Text(
                'Письмо отправлено на\n$email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: AppSpacing.s8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _secondsLeft > 0 ? null : () => _resend(context),
                  child: Text(
                    'Отправить повторно'
                    '${_secondsLeft > 0 ? ' (${_secondsLeft}с)' : ''}',
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s3),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Уже подтвердил'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
