import 'package:flutter/material.dart';
import '../theme/app_design_system.dart';
import '../../l10n/l10n_extension.dart';

class MedicationHeader extends StatelessWidget {
  final String name;
  final String dosage;
  final String? time;
  final String? subtitle;
  final Color? iconColor;

  const MedicationHeader({
    super.key,
    required this.name,
    required this.dosage,
    this.time,
    this.subtitle,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.s),
          decoration: BoxDecoration(
            color: (iconColor ?? primaryColor).withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.medication, color: iconColor ?? primaryColor),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle ?? context.l10n.dosageTaken(dosage),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        if (time != null)
          Text(
            time!, 
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold, 
              color: iconColor ?? primaryColor,
            ),
          ),
      ],
    );
  }
}
