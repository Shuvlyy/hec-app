import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_cards.dart';
import '../../../core/widgets/medication_widgets.dart';
import '../../../core/widgets/medication_info_cards.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/greeting_header.dart';
import '../../../core/theme/app_design_system.dart';
import '../../../l10n/l10n_extension.dart';
import '../../prescriptions/domain/medication.dart';
import 'home_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicationsAsync = ref.watch(homeMedicationsProvider);
    final avgAdherenceAsync = ref.watch(homeAdherenceRateProvider);
    final nextDoseAsync = ref.watch(nextDoseProvider);
    final laterTodayAsync = ref.watch(laterTodayMedicationsProvider);

    return Scaffold(
      body: medicationsAsync.when(
        data: (medications) => _HomeContent(
          medications: medications,
          avgAdherence: avgAdherenceAsync.value ?? 0.0,
          nextDose: nextDoseAsync.value,
          laterToday: laterTodayAsync.value ?? [],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(context.l10n.error(err.toString()))),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final List<Medication> medications;
  final double avgAdherence;
  final Medication? nextDose;
  final List<Medication> laterToday;

  const _HomeContent({
    required this.medications,
    required this.avgAdherence,
    this.nextDose,
    required this.laterToday,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl, 
        vertical: AppSpacing.xl,
      ),
      children: [
        const Gap(AppSpacing.xl),
        
        // Personalized Header
        GreetingHeader(
          greeting: context.l10n.goodMorning,
          name: 'Alex',
          onNotificationTap: () {
            // TODO: Implement notifications
          },
        ),
        const Gap(AppSpacing.xxl),

        // Adherence Overview
        SectionHeader(title: context.l10n.yourProgress, isUppercase: true),
        ComplianceCard(
          rate: avgAdherence,
          status: avgAdherence >= 0.9 ? context.l10n.excellent : context.l10n.onTrack,
        ),
        const Gap(AppSpacing.xxxl),

        // Primary Action: Next Dose
        SectionHeader(title: context.l10n.upNext),
        if (nextDose != null)
          MedicationActionCard(
            name: nextDose!.name,
            dosage: nextDose!.dosage,
            time: nextDose!.time?.localized(context) ?? context.l10n.now,
            instructions: nextDose!.localizedInstructions(context),
            onConfirm: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.doseRecorded)),
              );
            },
            onTap: () => context.push('/medication-details/${nextDose!.id}'),
          )
        else
          const _EmptyMedicationsCard(),
        
        const Gap(AppSpacing.xxxl),

        // Timeline: Later Today
        if (laterToday.isNotEmpty) ...[
          SectionHeader(title: context.l10n.laterToday),
          ...laterToday.map((med) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.m),
            child: AppCard(
              onTap: () => context.push('/medication-details/${med.id}'),
              child: MedicationHeader(
                name: med.name,
                dosage: med.dosage,
                subtitle: med.frequency.localized(context),
                time: med.time?.localized(context) ?? context.l10n.scheduled,
                iconColor: Colors.blue,
              ),
            ),
          )),
        ],

        const Gap(AppSpacing.xxl),
        
        // Doctor Bridge Quick Link
        const _DoctorBridgeLink(),
        
        const Gap(100),
      ],
    );
  }
}

class _EmptyMedicationsCard extends StatelessWidget {
  const _EmptyMedicationsCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              Icon(Icons.check_circle_outline, size: 48, color: AppColors.successGreen),
              const Gap(AppSpacing.m),
              Text(context.l10n.allMedicationsTaken),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorBridgeLink extends StatelessWidget {
  const _DoctorBridgeLink();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppCard(
      color: theme.colorScheme.primaryContainer.withAlpha(76),
      onTap: () => context.go('/my-doctors'),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.m),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(AppRadius.m),
            ),
            child: const Icon(Icons.person_search, color: Colors.white),
          ),
          const Gap(AppSpacing.l),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.connectWithDoctors,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.l10n.keepMedicalTeamUpdated,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: theme.colorScheme.primary),
        ],
      ),
    );
  }
}
