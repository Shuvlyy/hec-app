import 'package:flutter/material.dart';
import '../theme/app_design_system.dart';
import '../theme/theme.dart';
import 'medication_widgets.dart';
import '../../l10n/l10n_extension.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;
  final double? borderRadius;
  final BoxBorder? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final radius = borderRadius ?? AppRadius.l;

    return Container(
      decoration: BoxDecoration(
        color: color ?? theme.cardTheme.color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
        border: border ?? (isDark 
            ? Border.all(color: theme.colorScheme.outlineVariant, width: 0.5)
            : null),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppSpacing.l),
            child: child,
          ),
        ),
      ),
    );
  }
}

class MedicationActionCard extends StatelessWidget {
  final String name;
  final String dosage;
  final String time;
  final String? instructions;
  final VoidCallback onConfirm;
  final VoidCallback? onTap;

  const MedicationActionCard({
    super.key,
    required this.name,
    required this.dosage,
    required this.time,
    this.instructions,
    required this.onConfirm,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<SemanticColors>()!;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MedicationHeader(
            name: name,
            dosage: dosage,
            time: time,
          ),
          if (instructions != null) ...[
            const SizedBox(height: AppSpacing.m),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withAlpha(76),
                borderRadius: BorderRadius.circular(AppRadius.s),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withAlpha(128),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: Text(
                      instructions!,
                      style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withAlpha(178),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.l),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: semanticColors.success,
                foregroundColor: semanticColors.onSuccess,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.m),
                ),
              ),
              child: Text(context.l10n.confirmDoseTaken, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
