import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hec_app/core/widgets/logo.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/medication_info_cards.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/utils/mock_repositories.dart';
import '../../../core/theme/app_design_system.dart';
import '../../../l10n/l10n_extension.dart';

class MedicationDetailScreen extends ConsumerWidget {
  final String medicationId;

  const MedicationDetailScreen({
    super.key,
    required this.medicationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final prescriptionsAsync = ref.watch(mockPrescriptionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: theme.appBarTheme.iconTheme?.color,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: false,
      body: prescriptionsAsync.when(
        data: (prescriptions) {
          final medication = prescriptions
              .expand((p) => p.medications)
              .firstWhere((m) => m.id == medicationId);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Medication Image Placeholder
                Container(
                  width: double.infinity,
                  height: 250,
                  margin: const EdgeInsets.all(AppSpacing.xxl),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                  ),
                  child: Center(
                    child: Text(
                      'MEDICATION IMAGE\nPLACEHOLDER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatusBadge.active(context),
                      const SizedBox(height: AppSpacing.s),
                      Text(
                        medication.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${medication.dosage} • 1 tablet',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grayText.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      Row(
                        children: [
                          Expanded(
                            child: InfoHeaderCard(
                              icon: Icons.calendar_today_outlined,
                              label: context.l10n.frequency,
                              value: medication.frequency.localized(context),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.l),
                          Expanded(
                            child: InfoHeaderCard(
                              icon: Icons.calendar_month,
                              label: context.l10n.scheduledTime,
                              value: medication.time?.localized(context) ?? '08:00 AM',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.l),

                      SectionInfoCard(
                        title: context.l10n.reasonForUse,
                        items: [
                          SectionItem(
                            icon: Icons.favorite_outline,
                            iconColor: AppColors.medicalBlue,
                            text: medication.localizedReason(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.l),

                      SectionInfoCard(
                        title: context.l10n.specialInstructions,
                        items: [
                          SectionItem(
                            icon: Icons.restaurant_outlined,
                            iconColor: AppColors.medicalGreen,
                            text: medication.localizedInstructions(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.l),

                      ComplianceCard(
                        rate: medication.adherenceRate,
                        status: context.l10n.excellent,
                      ),
                      const SizedBox(height: AppSpacing.l),

                      RefillStatusCard(
                        remaining: medication.localizedRenewalStatus(context),
                        lastFilled: DateFormat('MMM d, yyyy').format(medication.lastFilled),
                      ),
                      const SizedBox(height: 30), // Bottom padding for navbar
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(context.l10n.error(err.toString()))),
      ),
    );
  }
}
