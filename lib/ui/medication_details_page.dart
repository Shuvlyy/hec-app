import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/providers/prescription_provider.dart';
import 'package:gap/gap.dart';
import 'package:milo/l10n/app_localizations.dart';

class MedicationDetailsPage extends ConsumerWidget {
  final String medicationId;
  const MedicationDetailsPage({super.key, required this.medicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptions = ref.watch(prescriptionProvider);
    final med = prescriptions
        .expand((p) => p.medications)
        .firstWhere((m) => m.id == medicationId);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.medicationDetails),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.image, size: 64, color: Color(0xFFFF8C42)),
            ),
            const Gap(32),
            Text(
              med.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              med.dosage,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Gap(32),
            _buildDetailRow(context, Icons.repeat, l10n.frequency, med.frequency.toDisplayString(l10n)),
            const Gap(16),
            _buildDetailRow(context, Icons.access_time, l10n.timeOptional, med.times.isEmpty ? '--:--' : med.times.join(', ')),
            const Gap(32),
            const Divider(),
            const Gap(32),
            Text(
              l10n.instructions, 
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(12),
            Text(
              med.instructions,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFFF8C42)),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label, 
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              value, 
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
