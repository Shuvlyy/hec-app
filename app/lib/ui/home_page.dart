import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repill/providers/prescription_provider.dart';
import 'package:repill/models/medication.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:repill/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medications = ref.watch(todayMedicationsProvider);
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMMM d').format(now);

    // Group by time
    final groupedMeds = <String, List<Medication>>{};
    for (final med in medications) {
      final time = med.time ?? 'As needed';
      groupedMeds.putIfAbsent(time, () => []).add(med);
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
            dateStr,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: allTaken ? const Color(0xFFE8F5E9) : const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  allTaken ? Icons.check_circle_outline : Icons.info_outline,
                  color: allTaken ? const Color(0xFF4CAF50) : const Color(0xFF0066AA),
                  size: 20,
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    allTaken ? l10n.allDosesTaken : l10n.dosesLeft(dosesLeft),
                    style: TextStyle(
                      color: allTaken ? const Color(0xFF4CAF50) : const Color(0xFF0066AA),
                      fontWeight: FontWeight.w500,
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => context.push('/medication-details/${med.id}'),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
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
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '${med.dosage} • ${med.time}',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  if (med.isTaken)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        l10n.taken,
                        style: const TextStyle(color: Color(0xFF4CAF50), fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              if (!med.isTaken) ...[
                const Gap(16),
                ElevatedButton(
                  onPressed: () => ref.read(prescriptionProvider.notifier).updateMedicationStatus(med.id, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(l10n.taken, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
