import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../domain/location_provider.dart';

class LocationPickerScreen extends ConsumerWidget {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(locationsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите салон'),
        centerTitle: true,
      ),
      body: locationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: AppSpacing.s3),
              const Text('Не удалось загрузить список салонов'),
              const SizedBox(height: AppSpacing.s4),
              ElevatedButton(
                onPressed: () => ref.refresh(locationsProvider),
                child: const Text('Повторить'),
              ),
            ],
          ),
        ),
        data: (locations) => ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: AppSpacing.s3,
          ),
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              margin: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s4,
                  vertical: AppSpacing.s2,
                ),
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primary.withOpacity(0.12),
                  child: Icon(Icons.location_on, color: colorScheme.primary),
                ),
                title: Text(
                  location.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.s1),
                    Text(location.address),
                    if (location.phone != null) ...[
                      const SizedBox(height: AppSpacing.s1),
                      Text(
                        location.phone!,
                        style: TextStyle(color: colorScheme.primary),
                      ),
                    ],
                  ],
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: colorScheme.primary,
                ),
                onTap: () {
                  ref.read(selectedLocationProvider.notifier).state = location;
                  context.go('/home');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
