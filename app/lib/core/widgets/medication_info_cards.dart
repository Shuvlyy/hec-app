import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/app_design_system.dart';
import '../theme/theme.dart';
import 'app_cards.dart';
import '../../l10n/l10n_extension.dart';

class InfoHeaderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const InfoHeaderCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.l),
      borderRadius: AppRadius.xl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor ?? theme.colorScheme.primary, size: 24),
          const Gap(AppSpacing.s),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(2),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionInfoCard extends StatelessWidget {
  final String title;
  final List<SectionItem> items;

  const SectionInfoCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      borderRadius: AppRadius.xl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontSize: 10,
              letterSpacing: 0.5,
            ),
          ),
          const Gap(AppSpacing.l),
          Column(
            spacing: AppSpacing.m,
            children: items.map((item) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s),
                  decoration: BoxDecoration(
            color: item.iconBackgroundColor ?? item.iconColor.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: item.iconColor, size: 18),
                ),
                const Gap(AppSpacing.m),
                Expanded(
                  child: Text(
                    item.text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )).toList(),
          )
        ],
      ),
    );
  }
}

class SectionItem {
  final IconData icon;
  final Color iconColor;
  final Color? iconBackgroundColor;
  final String text;

  const SectionItem({
    required this.icon,
    required this.iconColor,
    this.iconBackgroundColor,
    required this.text,
  });
}

class ComplianceCard extends StatelessWidget {
  final double rate;
  final String status;

  const ComplianceCard({
    super.key,
    required this.rate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<SemanticColors>()!;
    final complianceColor = semanticColors.success;

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.l),
      borderRadius: AppRadius.xl,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.l),
            decoration: BoxDecoration(
              color: complianceColor.withAlpha(25),
              borderRadius: BorderRadius.circular(AppRadius.l),
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: complianceColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
            ),
          ),
          const Gap(AppSpacing.l),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.adherenceRate,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${(rate * 100).toInt()}%',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(AppSpacing.s),
                    Text(
                      status,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: complianceColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RefillStatusCard extends StatelessWidget {
  final String remaining;
  final String lastFilled;

  const RefillStatusCard({
    super.key,
    required this.remaining,
    required this.lastFilled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      borderRadius: AppRadius.xl,
      color: isDark ? primaryColor.withAlpha(25) : const Color(0xFFF2F7FF),
      border: isDark ? Border.all(color: primaryColor.withAlpha(51)) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REFILL STATUS',
            style: theme.textTheme.labelMedium?.copyWith(
              color: isDark ? primaryColor : AppColors.medicalBlue,
              fontSize: 10,
            ),
          ),
          const Gap(4),
          Text(
            remaining,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF003366),
            ),
          ),
          Text(
            context.l10n.lastFilled(lastFilled),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
