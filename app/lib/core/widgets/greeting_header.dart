import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  final String greeting;
  final String name;
  final VoidCallback? onNotificationTap;

  const GreetingHeader({
    super.key,
    required this.greeting,
    required this.name,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            Text(
              name,
              style: theme.textTheme.headlineMedium,
            ),
          ],
        ),
        IconButton(
          onPressed: onNotificationTap,
          icon: const Icon(Icons.notifications_none),
          style: IconButton.styleFrom(
            backgroundColor: theme.colorScheme.surfaceContainerHighest.withAlpha(128),
            shape: const CircleBorder(),
          ),
        ),
      ],
    );
  }
}
