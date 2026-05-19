import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/app_cards.dart';
import '../../../core/utils/mock_repositories.dart';
import '../../../core/widgets/doctor_avatar.dart';
import '../../../core/widgets/medication_info_cards.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/theme/app_design_system.dart';
import '../../../l10n/l10n_extension.dart';
import '../domain/medication.dart';

class PrescriptionDetailScreen extends ConsumerWidget {
  final String prescriptionId;

  const PrescriptionDetailScreen({
    super.key,
    required this.prescriptionId,
  });

  int _parseTime(MedicationTime? time) {
    if (time == null) return 1440; // End of day if no time
    switch (time) {
      case MedicationTime.morning: return 480; // 8:00 AM
      case MedicationTime.morningEvening: return 480; // 8:00 AM
      case MedicationTime.evening: return 1080; // 6:00 PM
      case MedicationTime.night: return 1200; // 8:00 PM
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionsAsync = ref.watch(mockPrescriptionsProvider);

    return prescriptionsAsync.when(
      data: (prescriptions) {
        final prescription = prescriptions.firstWhere((p) => p.id == prescriptionId);
        
        // Sort medications chronologically
        final sortedMedications = List<Medication>.from(prescription.medications)
          ..sort((a, b) => _parseTime(a.time).compareTo(_parseTime(b.time)));

        final avgAdherence = sortedMedications.isEmpty 
            ? 0.0 
            : sortedMedications.map((m) => m.adherenceRate).reduce((a, b) => a + b) / sortedMedications.length;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DoctorAvatar(name: prescription.doctor.name, radius: 14, fontSize: 11),
                    const Gap(8),
                    Icon(Icons.arrow_forward_ios, size: 10, color: Colors.grey.shade400),
                    const Gap(8),
                    Text(
                      '#${prescription.id.toUpperCase()}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const Gap(2),
                Text(
                  DateFormat('MMMM d, yyyy').format(prescription.date),
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            centerTitle: true,
            toolbarHeight: 70,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).appBarTheme.iconTheme?.color,
                size: 20,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.l),
            children: [
              // Dashboard Stats
              InfoHeaderCard(
                icon: Icons.medication_outlined,
                label: context.l10n.medications.toUpperCase(),
                value: '${sortedMedications.length} Prescribed',
                iconColor: AppColors.primaryBlue,
              ),
              const Gap(AppSpacing.m),
              ComplianceCard(
                rate: avgAdherence,
                status: avgAdherence >= 0.9 ? context.l10n.excellent : context.l10n.good,
              ),
              
              const Gap(AppSpacing.xxl),
              Text(
                context.l10n.prescribedMedications,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Gap(AppSpacing.l),
              ...sortedMedications.map((med) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.m),
                child: AppCard(
                  onTap: () => context.push('/medication-details/${med.id}'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(AppRadius.m),
                        ),
                        child: const Icon(Icons.medication_rounded, color: AppColors.primaryBlue, size: 24),
                      ),
                      const Gap(AppSpacing.l),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    med.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                  ),
                                ),
                                if (med.time != null)
                                  StatusBadge(
                                    label: med.time!.localized(context),
                                    backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                                    textColor: AppColors.primaryBlue,
                                  ),
                              ],
                            ),
                            const Gap(2),
                            Text(
                              '${med.dosage} • ${med.frequency.localized(context)}',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Icon(Icons.info_outline_rounded, size: 12, color: Colors.grey.shade500),
                                const Gap(6),
                                Expanded(
                                  child: Text(
                                    med.localizedReason(context),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(AppSpacing.s),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, _) => Scaffold(body: Center(child: Text(context.l10n.error(err.toString())))),
    );
  }
}
