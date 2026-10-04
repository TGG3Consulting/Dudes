import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../domain/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    final state = ref.read(authNotifierProvider);
    if (state.hasError && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!state.hasError && context.mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.s8),
              Icon(Icons.content_cut, size: 48, color: primary),
              const SizedBox(height: AppSpacing.s4),
              const Text(
                'Войти',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.s8),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Введите email';
                        }
                        if (!value.contains('@')) {
                          return 'Введите корректный email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s4),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Пароль должен содержать не менее 6 символов';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s3),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push('/forgot-password'),
                  child: const Text('Забыли пароль?'),
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authState.isLoading
                      ? null
                      : () => _signIn(context),
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Войти'),
                ),
              ),
              const SizedBox(height: AppSpacing.s6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Нет аккаунта? '),
                  TextButton(
                    onPressed: () => context.go('/register'),
                    child: const Text('Зарегистрироваться'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
