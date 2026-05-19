import 'package:flutter/material.dart';
import '../theme/app_design_system.dart';
import '../../l10n/l10n_extension.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const StatusBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  factory StatusBadge.active(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return StatusBadge(
      label: context.l10n.active,
      backgroundColor: isDark
          ? AppColors.darkSuccessGreen.withOpacity(0.2)
          : AppColors.lightSuccessGreen,
      textColor: isDark
          ? const Color(0xFF81C784)
          : AppColors.successGreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.s),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
