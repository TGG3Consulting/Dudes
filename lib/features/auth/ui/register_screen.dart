import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../domain/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
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
      context.go('/verify-email');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.s6),
              const Text(
                'Создать аккаунт',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Заполните данные для регистрации',
                style: TextStyle(
                  color: onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: AppSpacing.s6),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Полное имя',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Введите ваше имя';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s3),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Телефон',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Введите номер телефона';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s3),
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
                        if (value == null || !value.contains('@')) {
                          return 'Введите корректный email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s3),
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
                    const SizedBox(height: AppSpacing.s3),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirm,
                      decoration: InputDecoration(
                        labelText: 'Подтвердите пароль',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirm = !_obscureConfirm;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Пароли не совпадают';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s6),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authState.isLoading
                      ? null
                      : () => _register(context),
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Зарегистрироваться'),
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Уже есть аккаунт? '),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Войти'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s4),
            ],
          ),
        ),
      ),
    );
  }
}
