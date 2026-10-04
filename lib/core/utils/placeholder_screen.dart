import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String screenId;
  final String screenName;

  const PlaceholderScreen({
    super.key,
    required this.screenId,
    required this.screenName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$screenId · $screenName')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(screenId, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(screenName, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            const Icon(Icons.construction, size: 48, color: Colors.orange),
            const SizedBox(height: 8),
            Text(
              'Under construction',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
