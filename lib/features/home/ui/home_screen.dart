import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../../locations/domain/location_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocation = ref.watch(selectedLocationProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dude's Barber Shop"),
        centerTitle: true,
        actions: [
          if (selectedLocation != null)
            TextButton.icon(
              onPressed: () => context.go('/location-picker'),
              icon: Icon(Icons.swap_horiz, color: colorScheme.primary, size: 18),
              label: Text(
                'Сменить',
                style: TextStyle(color: colorScheme.primary, fontSize: 13),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedLocation == null) ...[
              // Баннер выбора салона
              Card(
                color: colorScheme.primary.withOpacity(0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.s4),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: colorScheme.primary, size: 32),
                      const SizedBox(width: AppSpacing.s3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Выберите салон',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: AppSpacing.s1),
                            Text(
                              'Нужно выбрать салон для записи',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurface
                                      .withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s3),
                      ElevatedButton(
                        onPressed: () => context.go('/location-picker'),
                        child: const Text('Выбрать'),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              // Выбранный салон
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colorScheme.primary.withOpacity(0.12),
                    child: Icon(Icons.location_on, color: colorScheme.primary),
                  ),
                  title: Text(
                    selectedLocation.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(selectedLocation.address),
                  trailing: TextButton(
                    onPressed: () => context.go('/location-picker'),
                    child: const Text('Сменить'),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s6),
              Text(
                'Добро пожаловать!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Используйте меню снизу для записи, магазина и бонусов.',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
