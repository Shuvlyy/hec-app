import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/app_design_system.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isUppercase;

  const SectionHeader({
    super.key,
    required this.title,
    this.isUppercase = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isUppercase ? title.toUpperCase() : title,
          style: isUppercase 
            ? theme.textTheme.labelMedium
            : theme.textTheme.titleLarge,
        ),
        const Gap(AppSpacing.l),
      ],
    );
  }
}
