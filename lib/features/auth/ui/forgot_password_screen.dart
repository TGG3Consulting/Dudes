import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../domain/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.resetPassword(_emailController.text.trim());
    final state = ref.read(authNotifierProvider);
    if (state.hasError && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!state.hasError && context.mounted) {
      setState(() => _sent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сброс пароля'),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
          child: _sent ? _buildSuccess(context) : _buildForm(context, primary, isLoading),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, Color primary, bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppSpacing.s8),
        Icon(Icons.lock_reset_outlined, size: 64, color: primary),
        const SizedBox(height: AppSpacing.s6),
        const Text(
          'Забыли пароль?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.s3),
        const Text(
          'Введите email и мы отправим ссылку для сброса пароля.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s6),
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Введите корректный email';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: AppSpacing.s6),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : () => _submit(context),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Сбросить пароль'),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppSpacing.s8),
        const Icon(Icons.check_circle_outline, size: 72, color: Colors.green),
        const SizedBox(height: AppSpacing.s6),
        const Text(
          'Письмо отправлено!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s3),
        Text(
          'Проверьте ${_emailController.text} и перейдите по ссылке.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go('/login'),
            child: const Text('Вернуться к входу'),
          ),
        ),
      ],
    );
  }
}
