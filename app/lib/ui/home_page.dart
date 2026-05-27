import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/providers/prescription_provider.dart';
import 'package:milo/models/medication.dart';
import 'package:gap/gap.dart';
import 'package:milo/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer(
      builder: (context, ref, child) {
        final medications = ref.watch(todayMedicationsProvider);
        
        // Group by time
        final groupedMeds = <String, List<Medication>>{};
        for (final med in medications) {
          if (med.times.isEmpty) {
            groupedMeds.putIfAbsent('As needed', () => []).add(med);
          } else {
            for (final time in med.times) {
              groupedMeds.putIfAbsent(time, () => []).add(med);
            }
          }
        }

        final sortedTimes = groupedMeds.keys.toList()..sort();
        final dosesLeft = medications.where((m) => !m.isTaken).length;
        final allTaken = medications.isNotEmpty && dosesLeft == 0;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.today,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: allTaken ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      allTaken ? Icons.check_circle_outline : Icons.info_outline,
                      color: allTaken ? const Color(0xFF4CAF50) : const Color(0xFFFF8C42),
                      size: 20,
                    ),
                    const Gap(12),
                    Expanded(
                      child: Text(
                        allTaken ? l10n.allDosesTaken : l10n.dosesLeft(dosesLeft),
                        style: TextStyle(
                          color: allTaken ? const Color(0xFF4CAF50) : const Color(0xFFFF8C42),
                          fontWeight: FontWeight.w500,
                          fontSize: 16, // Body size
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(32),
              ...sortedTimes.map((time) => _buildTimelineSection(context, ref, time, groupedMeds[time]!)),
              const Gap(80), // Space for bottom bar
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimelineSection(BuildContext context, WidgetRef ref, String time, List<Medication> meds) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Icon(Icons.access_time, size: 20, color: Colors.grey),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: Colors.grey.shade200,
                ),
              ),
            ],
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    time,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Gap(16),
                ...meds.map((med) => _buildMedicationCard(context, ref, med)),
                const Gap(24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(BuildContext context, WidgetRef ref, Medication med) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => ref.read(prescriptionProvider.notifier).updateMedicationStatus(med.id, !med.isTaken),
        onLongPress: () => context.push('/medication-details/${med.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.medication, color: Color(0xFF4CAF50)),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      med.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Body size
                      ),
                    ),
                    Text(
                      med.dosage,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: med.isTaken,
                  onChanged: (value) {
                    ref.read(prescriptionProvider.notifier).updateMedicationStatus(med.id, value ?? false);
                  },
                  activeColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
